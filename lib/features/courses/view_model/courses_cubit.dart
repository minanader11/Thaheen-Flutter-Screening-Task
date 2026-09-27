import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/network/get_state.dart';
import '../repo/courses_repo.dart';
import 'courses_state.dart';

@injectable
class CoursesCubit extends Cubit<CoursesState> {
  final CoursesRepo coursesRepo;

  CoursesCubit({required this.coursesRepo}) : super(const CoursesState());

  Future<void> getCourses() async {
    emit(state.copyWith(coursesState: GetState.loading));
    final result = await coursesRepo.getCourses();
    if (result.isSuccess && result.data != null) {
      final lastWatched = coursesRepo.getLastWatched();
      emit(state.copyWith(
        coursesState: GetState.success,
        courses: result.data!,
        lastWatchedCourseId: lastWatched?['courseId'] as String?,
        lastWatchedLessonId: lastWatched?['lessonId'] as String?,
      ));
    } else {
      emit(state.copyWith(
        coursesState: GetState.failure,
        errorMessage: result.error ?? 'Failed to load courses',
      ));
    }
  }
}
