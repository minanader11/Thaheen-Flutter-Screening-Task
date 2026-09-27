import 'package:equatable/equatable.dart';
import 'lesson_model.dart';
import 'section_model.dart';

class CourseModel extends Equatable {
  final String id;
  final String title;
  final String instructor;
  final String thumbnail;
  final List<SectionModel> sections;

  const CourseModel({
    required this.id,
    required this.title,
    required this.instructor,
    required this.thumbnail,
    this.sections = const [],
  });

  // Derived getters, not stored:
  List<LessonModel> get flatLessons =>
      sections.expand((s) => s.lessons).toList();

  int get totalLessons => flatLessons.length;

  int get completedLessons => flatLessons.where((l) => l.isCompleted).length;

  double get progressPercent =>
      totalLessons == 0 ? 0.0 : completedLessons / totalLessons;

  LessonModel? get continueWatchingLesson {
    LessonModel? latestLesson;
    int latestTimestamp = 0;
    for (final l in flatLessons) {
      final t = l.progress.lastWatchedAt ?? 0;
      if (t > latestTimestamp) {
        latestTimestamp = t;
        latestLesson = l;
      }
    }
    if (latestLesson != null) return latestLesson;

    return flatLessons
        .cast<LessonModel?>()
        .firstWhere((l) => l!.progress.status == 'inProgress', orElse: () => null);
  }

  CourseModel copyWith({
    String? id,
    String? title,
    String? instructor,
    String? thumbnail,
    List<SectionModel>? sections,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      instructor: instructor ?? this.instructor,
      thumbnail: thumbnail ?? this.thumbnail,
      sections: sections ?? this.sections,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'instructor': instructor,
        'thumbnail': thumbnail,
        'sections': sections.map((s) => s.toJson()).toList(),
      };

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    final list = json['sections'] as List<dynamic>? ?? [];
    return CourseModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      instructor: json['instructor'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      sections: list
          .map((s) => SectionModel.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, title, instructor, thumbnail, sections];
}
