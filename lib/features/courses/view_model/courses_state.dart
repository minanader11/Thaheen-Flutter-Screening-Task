import 'package:equatable/equatable.dart';
import '../../../core/network/get_state.dart';
import '../model/course_model.dart';
import '../model/lesson_model.dart';

class CoursesState extends Equatable {
  final GetState coursesState; // initial/loading/success/failure
  final List<CourseModel> courses;
  final String errorMessage;
  final String? lastWatchedCourseId;
  final String? lastWatchedLessonId;

  final String searchQuery;

  const CoursesState({
    this.coursesState = GetState.initial,
    this.courses = const [],
    this.errorMessage = '',
    this.lastWatchedCourseId,
    this.lastWatchedLessonId,
    this.searchQuery = '',
  });

  CoursesState copyWith({
    GetState? coursesState,
    List<CourseModel>? courses,
    String? errorMessage,
    String? lastWatchedCourseId,
    String? lastWatchedLessonId,
    String? searchQuery,
  }) {
    return CoursesState(
      coursesState: coursesState ?? this.coursesState,
      courses: courses ?? this.courses,
      errorMessage: errorMessage ?? this.errorMessage,
      lastWatchedCourseId: lastWatchedCourseId ?? this.lastWatchedCourseId,
      lastWatchedLessonId: lastWatchedLessonId ?? this.lastWatchedLessonId,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<CourseModel> get filteredCourses {
    if (searchQuery.trim().isEmpty) return courses;
    final q = searchQuery.trim().toLowerCase();
    return courses.where((c) {
      final titleMatch = c.title.toLowerCase().contains(q);
      final instructorMatch = c.instructor.toLowerCase().contains(q);
      return titleMatch || instructorMatch;
    }).toList();
  }

  CourseModel? get continueWatchingCourse {
    // When actively searching, hide continue watching card to keep search focused
    if (searchQuery.trim().isNotEmpty) return null;

    // 1. If explicit lastWatched is recorded, find that course and verify it has the lesson
    if (lastWatchedCourseId != null && lastWatchedLessonId != null) {
      final matchedCourse = courses.cast<CourseModel?>().firstWhere(
            (c) => c?.id == lastWatchedCourseId,
            orElse: () => null,
          );
      if (matchedCourse != null) {
        final hasLesson =
            matchedCourse.flatLessons.any((l) => l.id == lastWatchedLessonId);
        if (hasLesson) return matchedCourse;
      }
    }

    // 2. Find course with latest timestamp across all lessons
    CourseModel? latestCourse;
    int latestTimestamp = 0;
    for (final c in courses) {
      for (final l in c.flatLessons) {
        final t = l.progress.lastWatchedAt ?? 0;
        if (t > latestTimestamp) {
          latestTimestamp = t;
          latestCourse = c;
        }
      }
    }
    if (latestCourse != null) return latestCourse;

    // 3. Fallback: first course with an inProgress lesson
    return courses.cast<CourseModel?>().firstWhere(
          (c) => c?.continueWatchingLesson != null,
          orElse: () => null,
        );
  }

  LessonModel? get continueWatchingLesson {
    final course = continueWatchingCourse;
    if (course == null) return null;

    if (lastWatchedLessonId != null && course.id == lastWatchedCourseId) {
      final matched = course.flatLessons.cast<LessonModel?>().firstWhere(
            (l) => l?.id == lastWatchedLessonId,
            orElse: () => null,
          );
      if (matched != null) return matched;
    }

    return course.continueWatchingLesson;
  }

  @override
  List<Object?> get props => [
        coursesState,
        courses,
        errorMessage,
        lastWatchedCourseId,
        lastWatchedLessonId,
        searchQuery,
      ];
}
