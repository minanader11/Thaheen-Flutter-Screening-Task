import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/network/get_state.dart';
import '../../courses/repo/courses_repo.dart';
import 'course_details_state.dart';

@injectable
class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  final CoursesRepo coursesRepo;
  final String courseId;

  CourseDetailsCubit({
    required this.coursesRepo,
    @factoryParam required this.courseId,
  }) : super(const CourseDetailsState());

  Future<void> getCourseDetails([String? id]) async {
    final targetId = (id != null && id.isNotEmpty) ? id : courseId;
    emit(state.copyWith(courseState: GetState.loading));
    final result = await coursesRepo.getCourseById(targetId);
    if (result.isSuccess && result.data != null) {
      emit(state.copyWith(
        courseState: GetState.success,
        course: result.data,
      ));
    } else {
      emit(state.copyWith(
        courseState: GetState.failure,
        errorMessage: result.error ?? 'Failed to load course details',
      ));
    }
  }

  Future<void> refresh() => getCourseDetails(courseId);

  Future<void> retry() => refresh();
}
