import 'package:equatable/equatable.dart';

import '../../../core/network/get_state.dart';
import '../../courses/model/course_model.dart';
import '../../courses/model/lesson_model.dart';

class LessonPlayerState extends Equatable {
  final GetState lessonState;
  final CourseModel? course;
  final String currentLessonId;

  final Duration position;
  final Duration duration;

  final bool isPlaying;
  final bool isCompleted;
  final bool isFullscreen;

  final double playbackSpeed;
  final String errorMessage;

  const LessonPlayerState({
    this.lessonState = GetState.initial,
    this.course,
    this.currentLessonId = '',
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.isCompleted = false,
    this.isFullscreen = false,
    this.playbackSpeed = 1.0,
    this.errorMessage = '',
  });

  LessonPlayerState copyWith({
    GetState? lessonState,
    CourseModel? course,
    String? currentLessonId,
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    bool? isCompleted,
    bool? isFullscreen,
    double? playbackSpeed,
    String? errorMessage,
    /// When true, forces [isCompleted] to false regardless of the current value.
    bool resetCompleted = false,
    /// When true, forces [position] to Duration.zero regardless of the current value.
    bool resetPosition = false,
  }) {
    return LessonPlayerState(
      lessonState: lessonState ?? this.lessonState,
      course: course ?? this.course,
      currentLessonId: currentLessonId ?? this.currentLessonId,
      position: resetPosition ? Duration.zero : (position ?? this.position),
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      isCompleted: resetCompleted ? false : (isCompleted ?? this.isCompleted),
      isFullscreen: isFullscreen ?? this.isFullscreen,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  LessonModel? get currentLesson {
    if (course == null || currentLessonId.isEmpty) {
      return null;
    }

    for (final lesson in course!.flatLessons) {
      if (lesson.id == currentLessonId) {
        return lesson;
      }
    }

    return null;
  }

  @override
  List<Object?> get props => [
        lessonState,
        course,
        currentLessonId,
        position,
        duration,
        isPlaying,
        isCompleted,
        isFullscreen,
        playbackSpeed,
        errorMessage,
      ];
}
