import '../../features/courses/model/lesson_model.dart';

/// Returns true if the lesson playback position is at or above 90% of duration.
/// Returns false if durationSec is 0 or negative, or position is below 90%.
bool isLessonComplete(int positionSec, int durationSec) {
  if (durationSec <= 0) return false;
  return positionSec / durationSec >= 0.9;
}

/// Determines whether a lesson at [index] in [flatLessons] is unlocked:
/// - Index 0 (first lesson) is always unlocked.
/// - Lessons at index > 0 are unlocked only if the previous lesson is completed.
bool isLessonUnlocked(List<LessonModel> flatLessons, int index) {
  if (index == 0) return true;
  if (index < 0 || index >= flatLessons.length) return false;
  return flatLessons[index - 1].isCompleted;
}

/// Finds the next lesson ID after [currentId] in the flattened list.
/// Returns null if [currentId] is not found or is the last lesson.
String? nextLessonId(List<LessonModel> flatLessons, String currentId) {
  final index = flatLessons.indexWhere((l) => l.id == currentId);
  if (index == -1 || index + 1 >= flatLessons.length) {
    return null;
  }
  return flatLessons[index + 1].id;
}
