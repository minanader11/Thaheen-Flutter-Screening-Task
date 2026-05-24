import 'package:equatable/equatable.dart';

// ─────────────────────────────────────────────────────────────────
// Enum — mirrors C# TaskType exactly
// ─────────────────────────────────────────────────────────────────

enum TaskType {
  daily,
  bonus,
  flash;

  /// Serialise to the string the backend expects (PascalCase).
  String toJson() => switch (this) {
        TaskType.daily => 'Daily',
        TaskType.bonus => 'Bonus',
        TaskType.flash => 'Flash',
      };

  /// Parse the string sent by the backend.
  static TaskType fromJson(String value) => switch (value) {
        'Daily' => TaskType.daily,
        'Bonus' => TaskType.bonus,
        'Flash' => TaskType.flash,
        _ => throw ArgumentError('Unknown TaskType: $value'),
      };

  /// Human-readable label used in the UI.
  String get label => switch (this) {
        TaskType.daily => 'Daily',
        TaskType.bonus => 'Bonus',
        TaskType.flash => 'Flash',
      };
}

// ─────────────────────────────────────────────────────────────────
// TaskModel
// ─────────────────────────────────────────────────────────────────

class TaskModel extends Equatable {
  final int id;
  final String name;
  final TaskType type;

  /// Stored as String to match the backend's `Points` string field.
  /// Use [pointsAsInt] when you need numeric operations.
  final String score;

  const TaskModel({
    required this.id,
    required this.name,
    required this.type,
    required this.score,
  });

  /// Parsed integer value of [score], defaults to 0 on parse failure.
  int get pointsAsInt => int.tryParse(score) ?? 0;

  // ── fromJson ─────────────────────────────────────────────────
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: TaskType.fromJson(json['type'] as String),
      // Backend field is called "score" in TaskDto
      score: (json['score'] ?? json['points'] ?? '0').toString(),
    );
  }

  // ── toJson ───────────────────────────────────────────────────
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type.toJson(),
        'score': score,
      };

  // ── copyWith ─────────────────────────────────────────────────
  TaskModel copyWith({
    int? id,
    String? name,
    TaskType? type,
    String? score,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [id, name, type, score];
}
