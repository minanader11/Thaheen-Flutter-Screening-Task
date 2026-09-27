import 'package:equatable/equatable.dart';
import '../../../core/network/get_state.dart';
import '../../courses/model/course_model.dart';

class CourseDetailsState extends Equatable {
  final GetState courseState;
  final CourseModel? course;
  final String errorMessage;

  const CourseDetailsState({
    this.courseState = GetState.initial,
    this.course,
    this.errorMessage = '',
  });

  CourseDetailsState copyWith({
    GetState? courseState,
    CourseModel? course,
    String? errorMessage,
  }) {
    return CourseDetailsState(
      courseState: courseState ?? this.courseState,
      course: course ?? this.course,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [courseState, course, errorMessage];
}
