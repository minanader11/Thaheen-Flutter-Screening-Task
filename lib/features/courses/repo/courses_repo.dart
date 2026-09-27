import '../../../core/network/api_result.dart';
import '../model/course_model.dart';

abstract class CoursesRepo {
  Future<ApiResult<List<CourseModel>>> getCourses();
  Future<ApiResult<CourseModel>> getCourseById(String courseId);
  Map<String, dynamic>? getLastWatched();
}
