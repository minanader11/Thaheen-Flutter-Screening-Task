import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/rules/lesson_rules.dart';
import '../../../core/network/api_result.dart';
import '../../../core/services/progress_local_service.dart';
import '../model/course_model.dart';
import 'courses_repo.dart';

@LazySingleton(as: CoursesRepo)
class CoursesRepoImpl implements CoursesRepo {
  final ProgressLocalService progressLocalService;

  CoursesRepoImpl({required this.progressLocalService});

  @override
  Future<ApiResult<List<CourseModel>>> getCourses() async {
    try {
      final raw = await rootBundle.loadString(AssetPaths.coursesData);
      final Map<String, dynamic> json = jsonDecode(raw);
      final List list = json['courses'] ?? [];

      final courses = list
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList();

      // merge saved progress on top of the bundled defaults
      final merged = courses.map((course) {
        final sections = course.sections.map((section) {
          final lessons = section.lessons.map((lesson) {
            final saved = progressLocalService.getProgress(lesson.id, course.id);
            if (saved != null) {
              // Sanitize: A lesson can ONLY be completed if it actually reached 90%
              if (saved.status == 'completed' &&
                  lesson.durationSec > 0 &&
                  !isLessonComplete(saved.positionSec, lesson.durationSec)) {
                final repaired = saved.copyWith(
                  status: saved.positionSec > 0 ? 'inProgress' : 'notStarted',
                );
                progressLocalService.saveProgress(lesson.id, repaired, course.id);
                return lesson.copyWith(progress: repaired);
              }
              return lesson.copyWith(progress: saved);
            }
            return lesson;
          }).toList();
          return section.copyWith(lessons: lessons);
        }).toList();
        return course.copyWith(sections: sections);
      }).toList();

      return ApiResult.success(merged);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<CourseModel>> getCourseById(String courseId) async {
    final result = await getCourses();
    if (!result.isSuccess || result.data == null) {
      return ApiResult.failure(result.error ?? 'Failed to load courses');
    }

    try {
      final course = result.data!.firstWhere((c) => c.id == courseId);
      return ApiResult.success(course);
    } catch (_) {
      return const ApiResult.failure('Course not found');
    }
  }

  @override
  Map<String, dynamic>? getLastWatched() {
    return progressLocalService.getLastWatched();
  }
}
