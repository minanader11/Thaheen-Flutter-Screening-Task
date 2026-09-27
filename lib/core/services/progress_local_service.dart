import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_keys.dart';
import '../../features/courses/model/lesson_progress_model.dart';

@lazySingleton
class ProgressLocalService {
  /// Retrieves saved progress for a lesson from local cache, optionally scoped by courseId.
  LessonProgressModel? getProgress(String lessonId, [String? courseId]) {
    final key = CacheKeys.lessonProgress(lessonId, courseId);
    final raw = CacheHelper.getData<String>(key: key);
    if (raw == null) return null;
    try {
      return LessonProgressModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  /// Persists progress for a lesson to local cache, optionally scoped by courseId.
  Future<void> saveProgress(
    String lessonId,
    LessonProgressModel progress, [
    String? courseId,
  ]) async {
    final progressWithTimestamp =
        (progress.lastWatchedAt != null && progress.lastWatchedAt! > 0)
            ? progress
            : progress.copyWith(
                lastWatchedAt: DateTime.now().millisecondsSinceEpoch,
              );

    final key = CacheKeys.lessonProgress(lessonId, courseId);
    await CacheHelper.saveData(
      key: key,
      value: jsonEncode(progressWithTimestamp.toJson()),
    );

    if (courseId != null && courseId.isNotEmpty) {
      await setLastWatched(courseId: courseId, lessonId: lessonId);
    }
  }

  /// Explicitly marks the specified lesson and course as the last watched video.
  Future<void> setLastWatched({
    required String courseId,
    required String lessonId,
  }) async {
    final data = jsonEncode({
      'courseId': courseId,
      'lessonId': lessonId,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    });
    await CacheHelper.saveData(
      key: CacheKeys.lastWatched,
      value: data,
    );
  }

  /// Retrieves the last watched course and lesson information from local cache.
  Map<String, dynamic>? getLastWatched() {
    final raw = CacheHelper.getData<String>(key: CacheKeys.lastWatched);
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Clears the last watched record.
  Future<void> clearLastWatched() async {
    await CacheHelper.removeData(key: CacheKeys.lastWatched);
  }
}
