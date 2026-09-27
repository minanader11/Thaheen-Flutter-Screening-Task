import 'package:flutter_test/flutter_test.dart';
import 'package:LJF_admin/core/network/api_result.dart';
import 'package:LJF_admin/core/network/get_state.dart';
import 'package:LJF_admin/features/courses/model/course_model.dart';
import 'package:LJF_admin/features/courses/model/lesson_model.dart';
import 'package:LJF_admin/features/courses/model/lesson_progress_model.dart';
import 'package:LJF_admin/features/courses/model/section_model.dart';
import 'package:LJF_admin/features/courses/repo/courses_repo.dart';
import 'package:LJF_admin/features/courses/view_model/courses_cubit.dart';
import 'package:LJF_admin/features/courses/view_model/courses_state.dart';

class FakeCoursesRepo implements CoursesRepo {
  ApiResult<List<CourseModel>> mockResult = const ApiResult.success([]);
  Map<String, dynamic>? mockLastWatched;

  @override
  Future<ApiResult<List<CourseModel>>> getCourses() async => mockResult;

  @override
  Future<ApiResult<CourseModel>> getCourseById(String courseId) async {
    return const ApiResult.failure('Not implemented');
  }

  @override
  Map<String, dynamic>? getLastWatched() => mockLastWatched;
}

void main() {
  group('CoursesCubit', () {
    late FakeCoursesRepo fakeRepo;
    late CoursesCubit cubit;

    setUp(() {
      fakeRepo = FakeCoursesRepo();
      cubit = CoursesCubit(coursesRepo: fakeRepo);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const CoursesState());
      expect(cubit.state.coursesState, GetState.initial);
      expect(cubit.state.courses, isEmpty);
      expect(cubit.state.errorMessage, '');
    });

    test('getCourses emits [loading, success] when repo succeeds', () async {
      const testCourse = CourseModel(
        id: 'c1',
        title: 'Course 1',
        instructor: 'Dr. Sarah',
        thumbnail: 'thumb.png',
        sections: [],
      );

      fakeRepo.mockResult = const ApiResult.success([testCourse]);

      final expectedStates = [
        const CoursesState(coursesState: GetState.loading),
        const CoursesState(coursesState: GetState.success, courses: [testCourse]),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.getCourses();
    });

    test('getCourses emits [loading, failure] when repo fails', () async {
      fakeRepo.mockResult = const ApiResult.failure('Failed to fetch data');

      final expectedStates = [
        const CoursesState(coursesState: GetState.loading),
        const CoursesState(coursesState: GetState.failure, errorMessage: 'Failed to fetch data'),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.getCourses();
    });

    test('continueWatchingCourse returns null when empty', () {
      expect(const CoursesState().continueWatchingCourse, isNull);
    });

    test('continueWatchingCourse and continueWatchingLesson return the last watched video instead of first course uncompleted video', () async {
      // Course 1 has an uncompleted lesson (inProgress) watched at t=100
      const course1 = CourseModel(
        id: 'course-1',
        title: 'Course 1',
        instructor: 'Dr. Sarah',
        thumbnail: 'thumb1.png',
        sections: [
          SectionModel(
            id: 's1',
            title: 'Section 1',
            lessons: [
              LessonModel(
                id: 'l1',
                title: 'Lesson 1',
                durationSec: 100,
                video: 'v1.mp4',
                progress: LessonProgressModel(
                  status: 'inProgress',
                  positionSec: 20,
                  lastWatchedAt: 100,
                ),
              ),
            ],
          ),
        ],
      );

      // Course 2 has the last watched lesson, watched at t=500
      const course2 = CourseModel(
        id: 'course-2',
        title: 'Course 2',
        instructor: 'Dr. Ahmed',
        thumbnail: 'thumb2.png',
        sections: [
          SectionModel(
            id: 's2',
            title: 'Section 2',
            lessons: [
              LessonModel(
                id: 'l2',
                title: 'Lesson 2',
                durationSec: 120,
                video: 'v2.mp4',
                progress: LessonProgressModel(
                  status: 'inProgress',
                  positionSec: 60,
                  lastWatchedAt: 500,
                ),
              ),
            ],
          ),
        ],
      );

      // When mockLastWatched points to course-2 / l2
      fakeRepo.mockResult = const ApiResult.success([course1, course2]);
      fakeRepo.mockLastWatched = {
        'courseId': 'course-2',
        'lessonId': 'l2',
      };

      await cubit.getCourses();

      expect(cubit.state.continueWatchingCourse?.id, 'course-2');
      expect(cubit.state.continueWatchingLesson?.id, 'l2');
    });

    test('CourseModel.continueWatchingLesson returns most recently watched lesson in the course', () {
      const course = CourseModel(
        id: 'course-1',
        title: 'Course 1',
        instructor: 'Dr. Sarah',
        thumbnail: 'thumb1.png',
        sections: [
          SectionModel(
            id: 's1',
            title: 'Section 1',
            lessons: [
              LessonModel(
                id: 'l1',
                title: 'Lesson 1',
                durationSec: 100,
                video: 'v1.mp4',
                progress: LessonProgressModel(
                  status: 'inProgress',
                  positionSec: 20,
                  lastWatchedAt: 100,
                ),
              ),
              LessonModel(
                id: 'l2',
                title: 'Lesson 2',
                durationSec: 120,
                video: 'v2.mp4',
                progress: LessonProgressModel(
                  status: 'inProgress',
                  positionSec: 50,
                  lastWatchedAt: 300,
                ),
              ),
            ],
          ),
        ],
      );

      expect(course.continueWatchingLesson?.id, 'l2');
    });

    test('searchCourses filters courses by title and instructor case-insensitively', () async {
      const course1 = CourseModel(
        id: 'anatomy-101',
        title: 'مقدمة في التشريح',
        instructor: 'د. سارة',
        thumbnail: 'thumb.png',
        sections: [],
      );
      const course2 = CourseModel(
        id: 'physio-101',
        title: 'علم وظائف الأعضاء',
        instructor: 'د. أحمد',
        thumbnail: 'thumb2.png',
        sections: [],
      );

      fakeRepo.mockResult = const ApiResult.success([course1, course2]);
      await cubit.getCourses();

      expect(cubit.state.filteredCourses.length, 2);

      // Search by title match
      cubit.searchCourses('التشريح');
      expect(cubit.state.filteredCourses.length, 1);
      expect(cubit.state.filteredCourses.first.id, 'anatomy-101');

      // Search by instructor match
      cubit.searchCourses('أحمد');
      expect(cubit.state.filteredCourses.length, 1);
      expect(cubit.state.filteredCourses.first.id, 'physio-101');

      // Search with non-matching query
      cubit.searchCourses('كيمياء');
      expect(cubit.state.filteredCourses.isEmpty, isTrue);

      // Clear search restores all courses
      cubit.clearSearch();
      expect(cubit.state.filteredCourses.length, 2);
    });
  });
}
