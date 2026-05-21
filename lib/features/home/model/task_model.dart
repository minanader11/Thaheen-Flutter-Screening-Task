import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/styles/colors.dart';

enum TaskType { daily, bonus, flash }

extension TaskTypeExtension on TaskType {
  String get value {
    switch (this) {
      case TaskType.daily:
        return "Daily";
      case TaskType.bonus:
        return "Bonus";
      case TaskType.flash:
        return "Flash";
    }
  }

  Color get color {
    switch (this) {
      case TaskType.daily:
        return ColorManager.dailyTask;
      case TaskType.bonus:
        return ColorManager.bonusTask;
      case TaskType.flash:
        return ColorManager.flashTask;
    }
  }

  static TaskType fromString(String value) {
    switch (value.toLowerCase()) {
      case "daily":
        return TaskType.daily;
      case "bonus":
        return TaskType.bonus;
      case "flash":
        return TaskType.flash;
      default:
        return TaskType.daily;
    }
  }
}

class TaskModel extends Equatable {
  final int id;
  final String name;
  final TaskType type;
  final String? points;

  const TaskModel({
    required this.id,
    required this.name,
    required this.type,
    this.points,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: TaskTypeExtension.fromString(json['type'] as String? ?? 'daily'),
      points: json['score'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, type, points];
}