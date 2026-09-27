import 'package:equatable/equatable.dart';
import 'lesson_progress_model.dart';

class LessonModel extends Equatable {
  final String id;
  final String title;
  final int durationSec;
  final String video; // asset path
  final LessonProgressModel progress;

  const LessonModel({
    required this.id,
    required this.title,
    required this.durationSec,
    required this.video,
    this.progress = const LessonProgressModel(),
  });

  bool get isCompleted => progress.status == 'completed';

  LessonModel copyWith({
    String? id,
    String? title,
    int? durationSec,
    String? video,
    LessonProgressModel? progress,
  }) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      durationSec: durationSec ?? this.durationSec,
      video: video ?? this.video,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'durationSec': durationSec,
        'video': video,
        'progress': progress.toJson(),
      };

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      durationSec: (json['durationSec'] as num?)?.toInt() ?? 0,
      video: json['video'] as String? ?? '',
      progress: json['progress'] != null
          ? LessonProgressModel.fromJson(json['progress'] as Map<String, dynamic>)
          : const LessonProgressModel(),
    );
  }

  @override
  List<Object?> get props => [id, title, durationSec, video, progress];
}
