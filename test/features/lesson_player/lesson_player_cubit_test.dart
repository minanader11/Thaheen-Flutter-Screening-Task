import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Thaheen/core/cache/cache_helper.dart';
import 'package:Thaheen/core/network/api_result.dart';
import 'package:Thaheen/core/network/get_state.dart';
import 'package:Thaheen/core/services/progress_local_service.dart';
import 'package:Thaheen/core/settings/model/app_settings_model.dart';
import 'package:Thaheen/core/settings/repo/settings_repo.dart';
import 'package:Thaheen/core/settings/view_model/settings_cubit.dart';
import 'package:Thaheen/features/courses/model/course_model.dart';
import 'package:Thaheen/features/courses/model/lesson_model.dart';
import 'package:Thaheen/features/courses/model/lesson_progress_model.dart';
import 'package:Thaheen/features/courses/model/section_model.dart';
import 'package:Thaheen/features/courses/repo/courses_repo.dart';
import 'package:Thaheen/features/lesson_player/view_model/lesson_player_cubit.dart';
import 'package:Thaheen/features/lesson_player/view_model/lesson_player_state.dart';

class FakeSettingsRepo implements SettingsRepo {
  AppSettingsModel settings = const AppSettingsModel();

  @override
  Future<AppSettingsModel> getSettings() async => settings;

  @override
  Future<void> saveSettings(AppSettingsModel newSettings) async {
    settings = newSettings;
  }
}

class FakeCoursesRepo implements CoursesRepo {
  ApiResult<CourseModel> mockCourse = const ApiResult.failure('Not found');

  @override
  Future<ApiResult<List<CourseModel>>> getCourses() async =>
      const ApiResult.success([]);

  @override
  Future<ApiResult<CourseModel>> getCourseById(String courseId) async =>
      mockCourse;

  @override
  Map<String, dynamic>? getLastWatched() => null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LessonPlayerCubit', () {
    late FakeCoursesRepo fakeCoursesRepo;
    late ProgressLocalService progressLocalService;
    late FakeSettingsRepo fakeSettingsRepo;
    late SettingsCubit settingsCubit;
    late LessonPlayerCubit cubit;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await CacheHelper.init();

      fakeCoursesRepo = FakeCoursesRepo();
      progressLocalService = ProgressLocalService();
      fakeSettingsRepo = FakeSettingsRepo();
      settingsCubit = SettingsCubit(settingsRepo: fakeSettingsRepo);

      cubit = LessonPlayerCubit(
        coursesRepo: fakeCoursesRepo,
        progressLocalService: progressLocalService,
        settingsCubit: settingsCubit,
        initialCourseId: 'course-1',
        initialLessonId: 'l1',
      );
    });

    tearDown(() {
      cubit.close();
      settingsCubit.close();
    });

    test('initial state has default values', () {
      expect(cubit.state, const LessonPlayerState());
      expect(cubit.state.lessonState, GetState.initial);
      expect(cubit.state.isPlaying, isFalse);
      expect(cubit.state.playbackSpeed, 1.0);
      expect(cubit.state.isFullscreen, isFalse);
    });

    test('initLesson emits failure when course or lesson ID is empty', () async {
      final expectedStates = [
        const LessonPlayerState(
          lessonState: GetState.failure,
          errorMessage: 'Invalid course or lesson ID',
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.initLesson('', '');
    });

    test('changeSpeed updates cubit state and persists to SettingsCubit', () {
      expect(cubit.state.playbackSpeed, 1.0);
      expect(settingsCubit.state.settings.lastPlaybackSpeed, 1.0);

      cubit.changeSpeed(1.5);

      expect(cubit.state.playbackSpeed, 1.5);
      expect(settingsCubit.state.settings.lastPlaybackSpeed, 1.5);
    });

    test('toggleFullscreen toggles isFullscreen state', () {
      expect(cubit.state.isFullscreen, isFalse);

      cubit.toggleFullscreen();
      expect(cubit.state.isFullscreen, isTrue);

      cubit.toggleFullscreen();
      expect(cubit.state.isFullscreen, isFalse);
    });

    test('canGoToNextLesson respects sequential unlock rule', () {
      const course = CourseModel(
        id: 'c1',
        title: 'Course 1',
        instructor: 'Dr. Test',
        thumbnail: 'thumb.png',
        sections: [
          SectionModel(
            id: 's1',
            title: 'S1',
            lessons: [
              LessonModel(
                id: 'l1',
                title: 'L1',
                durationSec: 100,
                video: 'v1.mp4',
                progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
              ),
              LessonModel(
                id: 'l2',
                title: 'L2',
                durationSec: 100,
                video: 'v2.mp4',
                progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
              ),
            ],
          ),
        ],
      );

      // l1 is not completed yet, so next lesson l2 is locked
      cubit.emit(cubit.state.copyWith(
        course: course,
        currentLessonId: 'l1',
      ));
      expect(cubit.canGoToNextLesson(), isFalse);

      // when l1 is completed, l2 is unlocked
      const completedCourse = CourseModel(
        id: 'c1',
        title: 'Course 1',
        instructor: 'Dr. Test',
        thumbnail: 'thumb.png',
        sections: [
          SectionModel(
            id: 's1',
            title: 'S1',
            lessons: [
              LessonModel(
                id: 'l1',
                title: 'L1',
                durationSec: 100,
                video: 'v1.mp4',
                progress: LessonProgressModel(status: 'completed', positionSec: 100),
              ),
              LessonModel(
                id: 'l2',
                title: 'L2',
                durationSec: 100,
                video: 'v2.mp4',
                progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
              ),
            ],
          ),
        ],
      );

      cubit.emit(cubit.state.copyWith(
        course: completedCourse,
        currentLessonId: 'l1',
      ));
      expect(cubit.canGoToNextLesson(), isTrue);

      // when current lesson is marked completed dynamically in cubit state, next lesson is unlocked
      cubit.emit(cubit.state.copyWith(
        course: course,
        currentLessonId: 'l1',
        isCompleted: true,
      ));
      expect(cubit.canGoToNextLesson(), isTrue);

      // when on the last lesson l2, there is no next lesson
      cubit.emit(cubit.state.copyWith(
        course: completedCourse,
        currentLessonId: 'l2',
      ));
      expect(cubit.canGoToNextLesson(), isFalse);
    });

    test('currentLesson returns matching lesson or null on miss', () {
      expect(const LessonPlayerState().currentLesson, isNull);

      const course = CourseModel(
        id: 'c1',
        title: 'Course 1',
        instructor: 'Dr. Test',
        thumbnail: 'thumb.png',
        sections: [
          SectionModel(
            id: 's1',
            title: 'S1',
            lessons: [
              LessonModel(
                id: 'l1',
                title: 'Lesson 1',
                durationSec: 100,
                video: 'v1.mp4',
                progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
              ),
            ],
          ),
        ],
      );

      const stateWithMatch = LessonPlayerState(
        course: course,
        currentLessonId: 'l1',
      );
      expect(stateWithMatch.currentLesson?.id, 'l1');

      const stateWithMiss = LessonPlayerState(
        course: course,
        currentLessonId: 'non-existent',
      );
      expect(stateWithMiss.currentLesson, isNull);
    });

    test('retry calls initLesson reusing stored courseId and lessonId', () async {
      fakeCoursesRepo.mockCourse = const ApiResult.failure('Failed to load');

      final expectedStates = [
        const LessonPlayerState(
          lessonState: GetState.loading,
          currentLessonId: 'l1',
        ),
        const LessonPlayerState(
          lessonState: GetState.failure,
          errorMessage: 'Failed to load',
          currentLessonId: 'l1',
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.retry();
    });

    test('canGoToNextLesson returns false when current lesson is not completed', () {
      const course = CourseModel(
        id: 'c1',
        title: 'Course 1',
        instructor: 'Dr. Test',
        thumbnail: 'thumb.png',
        sections: [
          SectionModel(
            id: 's1',
            title: 'S1',
            lessons: [
              LessonModel(
                id: 'l1',
                title: 'L1',
                durationSec: 100,
                video: 'v1.mp4',
                progress: LessonProgressModel(status: 'completed', positionSec: 100),
              ),
              LessonModel(
                id: 'l2',
                title: 'L2',
                durationSec: 100,
                video: 'v2.mp4',
                progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
              ),
              LessonModel(
                id: 'l3',
                title: 'L3',
                durationSec: 100,
                video: 'v3.mp4',
                progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
              ),
            ],
          ),
        ],
      );

      // On lesson 2 (uncompleted)
      cubit.emit(cubit.state.copyWith(
        course: course,
        currentLessonId: 'l2',
        isCompleted: false,
        position: Duration.zero,
      ));

      expect(cubit.canGoToNextLesson(), isFalse);
    });
  });
}
