import 'package:equatable/equatable.dart';

class TeamModel extends Equatable {
  final int id;
  final String name;
  final int score;
  final String? image; // Base64 string
  final String? colorCode;
  final List<TeamSuperPower> teamSuperPowers;

  const TeamModel({
    required this.id,
    required this.name,
    required this.score,
    required this.image,
    required this.colorCode,
    required this.teamSuperPowers,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as int,
      name: json['name'] as String,
      score: json['score'] as int,

      // Base64 image (keep raw string)
      image: json['image'] as String?,

      // Keep full color (#2EC4A0), don’t strip #
      colorCode: json['colorCode'] as String?,

      teamSuperPowers: (json['teamSuperPowers'] as List<dynamic>?)
          ?.map((e) => TeamSuperPower.fromJson(e))
          .toList() ??
          [],
    );
  }

  TeamModel copyWith({
    int? id,
    String? name,
    int? score,
    String? image,
    String? colorCode,
    List<TeamSuperPower>? teamSuperPowers,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      score: score ?? this.score,
      image: image ?? this.image,
      colorCode: colorCode ?? this.colorCode,
      teamSuperPowers: teamSuperPowers ?? this.teamSuperPowers,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    score,
    image,
    colorCode,
    teamSuperPowers,
  ];
}
class TeamSuperPower {
  final int id;
  final int teamId;
  final String type;
  final String status;
  final DateTime? activatedAt;
  final DateTime? deactivatedAt;
  final int? targetTeamId;
  final String? imageBase64;

  TeamSuperPower({
    required this.id,
    required this.teamId,
    required this.type,
    required this.status,
    this.activatedAt,
    this.deactivatedAt,
    this.targetTeamId,
    this.imageBase64,
  });

  factory TeamSuperPower.fromJson(Map<String, dynamic> json) {
    return TeamSuperPower(
      id: json['id'],
      teamId: json['teamId'],
      type: json['type'],
      status: json['status'],
      activatedAt: json['activatedAt'] != null
          ? DateTime.parse(json['activatedAt'])
          : null,
      deactivatedAt: json['deactivatedAt'] != null
          ? DateTime.parse(json['deactivatedAt'])
          : null,
      targetTeamId: json['targetTeamId'],
      imageBase64: json['imageBase64'],
    );
  }
}