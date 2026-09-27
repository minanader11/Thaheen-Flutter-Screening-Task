/// Centralized cache key constants.
/// Follows AGENTS.md Section 4.
class CacheKeys {
  // LMS Settings & Progress keys
  static const String appSettings = "app_settings_json";
  static const String lessonProgressPrefix = "lesson_progress_";
  static const String lessonNotePrefix = "lesson_note_";
  static const String lastWatched = "last_watched_lesson";

  /// Legacy/auth cache keys
  static const String accessToken = "kdchfbkhfbskbfsrf";
  static const String appLanguage = "srgdfadtjjewrwer";

  /// Helper method to generate progress cache key for a specific lesson,
  /// optionally scoped by courseId to prevent progress collisions across courses.
  static String lessonProgress(String lessonId, [String? courseId]) {
    if (courseId != null && courseId.isNotEmpty) {
      return "$lessonProgressPrefix${courseId}_$lessonId";
    }
    return "$lessonProgressPrefix$lessonId";
  }

  /// Helper method to generate note cache key for a specific lesson in a course.
  static String lessonNote(String courseId, String lessonId) {
    return "$lessonNotePrefix${courseId}_$lessonId";
  }
}
