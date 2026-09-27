import 'package:flutter_test/flutter_test.dart';
import 'package:LJF_admin/core/network/api_result.dart';
import 'package:LJF_admin/core/network/get_state.dart';
import 'package:LJF_admin/features/course_details/view_model/course_details_cubit.dart';
import 'package:LJF_admin/features/course_details/view_model/course_details_state.dart';
import 'package:LJF_admin/features/courses/model/course_model.dart';
import 'package:LJF_admin/features/courses/repo/courses_repo.dart';

class FakeCoursesRepo implements CoursesRepo {
  ApiResult<CourseModel> mockCourseResult = const ApiResult.failure('Not found');

  @override
  Future<ApiResult<List<CourseModel>>> getCourses() async =>
      const ApiResult.success([]);

  @override
  Future<ApiResult<CourseModel>> getCourseById(String courseId) async =>
      mockCourseResult;

  @override
  Map<String, dynamic>? getLastWatched() => null;
}

void main() {
  group('CourseDetailsCubit', () {
    late FakeCoursesRepo fakeRepo;
    late CourseDetailsCubit cubit;

    setUp(() {
      fakeRepo = FakeCoursesRepo();
      cubit = CourseDetailsCubit(coursesRepo: fakeRepo, courseId: 'test-101');
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const CourseDetailsState());
      expect(cubit.state.courseState, GetState.initial);
      expect(cubit.state.course, isNull);
      expect(cubit.state.errorMessage, '');
    });

    test('getCourseDetails emits [loading, success] when course is found', () async {
      const course = CourseModel(
        id: 'test-101',
        title: 'Anatomy 101',
        instructor: 'Dr. Sarah',
        thumbnail: 'thumb.png',
        sections: [],
      );

      fakeRepo.mockCourseResult = const ApiResult.success(course);

      final expectedStates = [
        const CourseDetailsState(courseState: GetState.loading),
        const CourseDetailsState(courseState: GetState.success, course: course),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.getCourseDetails();
    });

    test('getCourseDetails emits [loading, failure] when course is not found', () async {
      fakeRepo.mockCourseResult = const ApiResult.failure('Course not found');

      final expectedStates = [
        const CourseDetailsState(courseState: GetState.loading),
        const CourseDetailsState(
          courseState: GetState.failure,
          errorMessage: 'Course not found',
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.getCourseDetails();
    });

    test('refresh calls getCourseDetails reusing stored courseId', () async {
      fakeRepo.mockCourseResult = const ApiResult.failure('Network error');

      final expectedStates = [
        const CourseDetailsState(courseState: GetState.loading),
        const CourseDetailsState(
          courseState: GetState.failure,
          errorMessage: 'Network error',
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.refresh();
    });
  });
}
