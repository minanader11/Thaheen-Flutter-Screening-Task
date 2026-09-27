import 'package:equatable/equatable.dart';
import 'lesson_model.dart';

class SectionModel extends Equatable {
  final String id;
  final String title;
  final List<LessonModel> lessons;

  const SectionModel({
    required this.id,
    required this.title,
    this.lessons = const [],
  });

  SectionModel copyWith({
    String? id,
    String? title,
    List<LessonModel>? lessons,
  }) {
    return SectionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      lessons: lessons ?? this.lessons,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'lessons': lessons.map((l) => l.toJson()).toList(),
      };

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    final list = json['lessons'] as List<dynamic>? ?? [];
    return SectionModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      lessons: list
          .map((l) => LessonModel.fromJson(l as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, title, lessons];
}
