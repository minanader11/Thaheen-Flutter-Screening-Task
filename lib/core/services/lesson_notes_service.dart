import 'package:injectable/injectable.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_keys.dart';

/// Local offline persistence service for user's per-lesson notes.
@lazySingleton
class LessonNotesService {
  /// Retrieves any saved note for the given lesson in a course.
  String? getNote({
    required String courseId,
    required String lessonId,
  }) {
    final key = CacheKeys.lessonNote(courseId, lessonId);
    return CacheHelper.getData<String>(key: key);
  }

  /// Persists a note for the specified lesson.
  Future<void> saveNote({
    required String courseId,
    required String lessonId,
    required String note,
  }) async {
    final trimmed = note.trim();
    final key = CacheKeys.lessonNote(courseId, lessonId);
    if (trimmed.isEmpty) {
      await CacheHelper.removeData(key: key);
    } else {
      await CacheHelper.saveData(key: key, value: trimmed);
    }
  }

  /// Deletes any note associated with the specified lesson.
  Future<void> deleteNote({
    required String courseId,
    required String lessonId,
  }) async {
    final key = CacheKeys.lessonNote(courseId, lessonId);
    await CacheHelper.removeData(key: key);
  }
}
