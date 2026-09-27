import 'package:equatable/equatable.dart';

class LessonProgressModel extends Equatable {
  final String status; // notStarted | inProgress | completed
  final int positionSec;
  final int? lastWatchedAt;

  const LessonProgressModel({
    this.status = 'notStarted',
    this.positionSec = 0,
    this.lastWatchedAt,
  });

  LessonProgressModel copyWith({
    String? status,
    int? positionSec,
    int? lastWatchedAt,
  }) {
    return LessonProgressModel(
      status: status ?? this.status,
      positionSec: positionSec ?? this.positionSec,
      lastWatchedAt: lastWatchedAt ?? this.lastWatchedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'positionSec': positionSec,
        if (lastWatchedAt != null) 'lastWatchedAt': lastWatchedAt,
      };

  factory LessonProgressModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const LessonProgressModel();
    return LessonProgressModel(
      status: json['status'] as String? ?? 'notStarted',
      positionSec: (json['positionSec'] as num?)?.toInt() ?? 0,
      lastWatchedAt: (json['lastWatchedAt'] as num?)?.toInt(),
    );
  }

  @override
  List<Object?> get props => [status, positionSec, lastWatchedAt];
}
