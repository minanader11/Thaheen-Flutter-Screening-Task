import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';
import '../../../core/lesson_rules.dart';
import '../../../core/network/get_state.dart';
import '../../../core/services/progress_local_service.dart';
import '../../../core/settings/view_model/settings_cubit.dart';
import '../../courses/model/course_model.dart';
import '../../courses/model/lesson_model.dart';
import '../../courses/model/lesson_progress_model.dart';
import '../../courses/repo/courses_repo.dart';
import 'lesson_player_state.dart';

@injectable
class LessonPlayerCubit extends Cubit<LessonPlayerState> {
  final CoursesRepo coursesRepo;
  final ProgressLocalService progressLocalService;
  final SettingsCubit settingsCubit;
  final String? initialCourseId;
  final String? initialLessonId;

  VideoPlayerController? controller;
  DateTime _lastPositionSave = DateTime.now();

  LessonPlayerCubit({
    required this.coursesRepo,
    required this.progressLocalService,
    required this.settingsCubit,
    @factoryParam this.initialCourseId,
    @factoryParam this.initialLessonId,
  }) : super(const LessonPlayerState());

  Future<void> initLesson([String? courseId, String? lessonId]) async {
    final cId = courseId ?? initialCourseId ?? state.course?.id ?? '';
    final lId = lessonId ?? initialLessonId ?? state.currentLessonId;

    if (cId.isEmpty || lId.isEmpty) {
      emit(state.copyWith(
        lessonState: GetState.failure,
        errorMessage: 'Invalid course or lesson ID',
      ));
      return;
    }

    // 1. Clean up and persist the PREVIOUS lesson BEFORE changing currentLessonId!
    final previousLessonId = state.currentLessonId;
    if (controller != null) {
      controller!.removeListener(_onTick);
      if (previousLessonId.isNotEmpty) {
        await _persistCurrentProgress(previousLessonId);
      }
      await controller!.dispose();
      controller = null;
    }

    // 2. Now emit loading state for the NEW lesson with position & completed reset
    emit(state.copyWith(
      lessonState: GetState.loading,
      currentLessonId: lId,
      resetCompleted: true,
      resetPosition: true,
    ));

    // Fetch course
    final result = await coursesRepo.getCourseById(cId);
    if (!result.isSuccess || result.data == null) {
      emit(state.copyWith(
        lessonState: GetState.failure,
        errorMessage: result.error ?? 'Failed to load course data',
      ));
      return;
    }

    final course = result.data!;
    final lesson = course.flatLessons.cast<LessonModel?>().firstWhere(
          (l) => l?.id == lId,
          orElse: () => null,
        );

    if (lesson == null) {
      emit(state.copyWith(
        lessonState: GetState.failure,
        errorMessage: 'Lesson not found',
      ));
      return;
    }

    final initialSpeed = settingsCubit.state.settings.lastPlaybackSpeed;

    try {
      final videoController = VideoPlayerController.asset(lesson.video);
      await videoController.initialize();
      controller = videoController;

      final effectiveDuration = videoController.value.duration > Duration.zero
          ? videoController.value.duration
          : (lesson.durationSec > 0
              ? Duration(seconds: lesson.durationSec)
              : Duration.zero);

      if (videoController.value.duration <= Duration.zero &&
          effectiveDuration > Duration.zero) {
        videoController.value = videoController.value.copyWith(
          duration: effectiveDuration,
        );
      }

      // Resume from saved position
      final resumeSec = lesson.progress.positionSec;
      if (resumeSec > 0 &&
          (effectiveDuration.inSeconds == 0 ||
              resumeSec < effectiveDuration.inSeconds)) {
        await videoController.seekTo(Duration(seconds: resumeSec));
      }

      await videoController.setPlaybackSpeed(initialSpeed);
      videoController.addListener(_onTick);

      await progressLocalService.setLastWatched(courseId: cId, lessonId: lId);

      emit(state.copyWith(
        lessonState: GetState.success,
        course: course,
        currentLessonId: lId,
        position: videoController.value.position,
        duration: effectiveDuration,
        isPlaying: videoController.value.isPlaying,
        isCompleted: lesson.isCompleted,
        playbackSpeed: initialSpeed,
      ));
    } catch (e) {
      emit(state.copyWith(
        lessonState: GetState.failure,
        errorMessage: 'Failed to load video: $e',
      ));
    }
  }

  Future<void> retry() async {
    final cId = initialCourseId ?? state.course?.id;
    final lId = state.currentLessonId.isNotEmpty
        ? state.currentLessonId
        : initialLessonId;
    await initLesson(cId, lId);
  }

  Future<void> refresh() => retry();

  void _onTick() {
    if (controller == null || !controller!.value.isInitialized) return;

    var pos = controller!.value.position;
    var dur = controller!.value.duration;
    final isPlaying = controller!.value.isPlaying;

    if (dur <= Duration.zero) {
      if (state.duration > Duration.zero) {
        dur = state.duration;
      } else {
        final currentLesson = state.currentLesson;
        if (currentLesson != null && currentLesson.durationSec > 0) {
          dur = Duration(seconds: currentLesson.durationSec);
        }
      }
      if (dur > Duration.zero) {
        controller!.value = controller!.value.copyWith(duration: dur);
      }
    }

    if (dur > Duration.zero && pos > dur) {
      pos = dur;
    }

    // Check 90% completion rule
    bool newlyCompleted = false;
    final cId = state.course?.id ?? initialCourseId;
    if (!state.isCompleted &&
        dur.inSeconds > 0 &&
        isLessonComplete(pos.inSeconds, dur.inSeconds)) {
      newlyCompleted = true;
      progressLocalService.saveProgress(
        state.currentLessonId,
        LessonProgressModel(
          status: 'completed',
          positionSec: pos.inSeconds,
        ),
        cId,
      );
    }

    // Persist position periodically (every 3 seconds or on completion)
    final now = DateTime.now();
    if (newlyCompleted || now.difference(_lastPositionSave).inSeconds >= 3) {
      _lastPositionSave = now;
      if (!newlyCompleted && pos.inSeconds > 0) {
        progressLocalService.saveProgress(
          state.currentLessonId,
          LessonProgressModel(
            status: state.isCompleted ? 'completed' : 'inProgress',
            positionSec: pos.inSeconds,
          ),
          cId,
        );
      }
    }

    final bool isCompletedNow = state.isCompleted || newlyCompleted;
    CourseModel? updatedCourse = state.course;
    if (updatedCourse != null && isCompletedNow) {
      final currentInCourse = updatedCourse.flatLessons.cast<LessonModel?>().firstWhere(
            (l) => l?.id == state.currentLessonId,
            orElse: () => null,
          );
      if (currentInCourse != null && !currentInCourse.isCompleted) {
        updatedCourse = _updateCourseLessonProgress(
          updatedCourse,
          state.currentLessonId,
          LessonProgressModel(
            status: 'completed',
            positionSec: pos.inSeconds,
          ),
        );
      }
    }

    emit(state.copyWith(
      position: pos,
      duration: dur,
      isPlaying: isPlaying,
      isCompleted: isCompletedNow,
      course: updatedCourse,
    ));
  }

  CourseModel _updateCourseLessonProgress(
    CourseModel course,
    String lessonId,
    LessonProgressModel progress,
  ) {
    final sections = course.sections.map((section) {
      final lessons = section.lessons.map((lesson) {
        if (lesson.id == lessonId) {
          return lesson.copyWith(progress: progress);
        }
        return lesson;
      }).toList();
      return section.copyWith(lessons: lessons);
    }).toList();
    return course.copyWith(sections: sections);
  }

  Future<void> _persistCurrentProgress([String? lessonId]) async {
    final targetLessonId = lessonId ?? state.currentLessonId;
    if (controller == null || targetLessonId.isEmpty) return;
    final posSec = controller!.value.position.inSeconds;
    final durSec = state.duration.inSeconds > 0
        ? state.duration.inSeconds
        : controller!.value.duration.inSeconds;
    final completed =
        state.isCompleted || (durSec > 0 && isLessonComplete(posSec, durSec));
    final cId = state.course?.id ?? initialCourseId;

    await progressLocalService.saveProgress(
      targetLessonId,
      LessonProgressModel(
        status: completed ? 'completed' : 'inProgress',
        positionSec: posSec,
      ),
      cId,
    );
  }

  void togglePlayPause() {
    if (controller == null || !controller!.value.isInitialized) return;
    if (controller!.value.isPlaying) {
      controller!.pause();
    } else {
      controller!.play();
    }
  }

  void seekTo(Duration position) {
    if (controller == null || !controller!.value.isInitialized) return;
    final maxDur = state.duration > Duration.zero
        ? state.duration
        : controller!.value.duration;

    if (controller!.value.duration <= Duration.zero && maxDur > Duration.zero) {
      controller!.value = controller!.value.copyWith(duration: maxDur);
    }

    final clampedSec = position.inSeconds.clamp(
      0,
      maxDur.inSeconds > 0 ? maxDur.inSeconds : 0,
    );
    final targetPosition = Duration(seconds: clampedSec);

    controller!.seekTo(targetPosition);
    emit(state.copyWith(position: targetPosition));
  }

  void seekForward([int seconds = 10]) {
    final currentPos = controller != null && controller!.value.isInitialized
        ? (controller!.value.position > state.position
            ? controller!.value.position
            : state.position)
        : state.position;
    seekTo(currentPos + Duration(seconds: seconds));
  }

  void seekBackward([int seconds = 10]) {
    final currentPos = controller != null && controller!.value.isInitialized
        ? (controller!.value.position > Duration.zero
            ? controller!.value.position
            : state.position)
        : state.position;
    seekTo(currentPos - Duration(seconds: seconds));
  }

  void changeSpeed(double speed) {
    if (controller != null && controller!.value.isInitialized) {
      controller!.setPlaybackSpeed(speed);
    }
    settingsCubit.updateLastPlaybackSpeed(speed);
    emit(state.copyWith(playbackSpeed: speed));
  }

  void toggleFullscreen() {
    emit(state.copyWith(isFullscreen: !state.isFullscreen));
  }

  bool canGoToNextLesson() {
    if (state.course == null || state.currentLessonId.isEmpty) return false;
    final flat = state.course!.flatLessons;
    final nextId = nextLessonId(flat, state.currentLessonId);
    if (nextId == null) return false;
    final nextIdx = flat.indexWhere((l) => l.id == nextId);
    if (nextIdx == -1) return false;
    if (state.isCompleted &&
        nextIdx > 0 &&
        flat[nextIdx - 1].id == state.currentLessonId) {
      return true;
    }
    return isLessonUnlocked(flat, nextIdx);
  }

  void goToNextLesson() {
    if (state.course == null || state.currentLessonId.isEmpty) return;
    final flat = state.course!.flatLessons;
    final nextId = nextLessonId(flat, state.currentLessonId);
    if (nextId == null) return;
    if (canGoToNextLesson()) {
      initLesson(state.course!.id, nextId);
    }
  }

  @override
  Future<void> close() async {
    await _persistCurrentProgress();
    controller?.removeListener(_onTick);
    await controller?.dispose();
    controller = null;
    return super.close();
  }
}
