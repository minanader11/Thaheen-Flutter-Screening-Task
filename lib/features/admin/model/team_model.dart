import 'package:equatable/equatable.dart';

import 'team_super_power_model.dart';

class TeamModel extends Equatable {
  final int id;
  final String name;
  final int score;
  final String image; // base64
  final String colorCode; // e.g. "#E63939"
  final List<TeamSuperPower> teamSuperPowers;

  // ── New: Car build ──────────────────────────────────────────
  final double carCompletionPercentage;

  // ── New: Bank ────────────────────────────────────────────────
  final double bankBalance;

  const TeamModel({
    required this.id,
    required this.name,
    required this.score,
    required this.image,
    required this.colorCode,
    this.teamSuperPowers = const [],
    this.carCompletionPercentage = 0,
    this.bankBalance = 0,
  });

  // ── Convenience getters ──────────────────────────────────────

  /// The currently active superpower, or null if none is active.
  TeamSuperPower? get activeSuperPower {
    try {
      return teamSuperPowers.firstWhere((p) => p.isActive);
    } catch (_) {
      return null;
    }
  }

  /// Whether this team has any superpower currently active.
  bool get hasSuperPowerActive => activeSuperPower != null;

  /// Returns the superpower of [type], or null.
  TeamSuperPower? superPowerOf(SuperPowerType type) {
    try {
      return teamSuperPowers.firstWhere((p) => p.type == type);
    } catch (_) {
      return null;
    }
  }

  // ── fromJson ─────────────────────────────────────────────────
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    final rawPowers = json['teamSuperPowers'] as List<dynamic>? ?? [];
    return TeamModel(
      id: json['id'] as int,
      name: json['name'] as String,
      score: json['score'] as int,
      image: json['image'] as String? ?? '',
      colorCode: json['colorCode'] as String? ?? '#FFFFFF',
      teamSuperPowers: rawPowers
          .map((e) => TeamSuperPower.fromJson(e as Map<String, dynamic>))
          .toList(),
      carCompletionPercentage:
      (json['carCompletionPercentage'] as num?)?.toDouble() ?? 0,
      bankBalance: (json['bankBalance'] as num?)?.toDouble() ?? 0,
    );
  }

  // ── toJson ───────────────────────────────────────────────────
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'score': score,
    'image': image,
    'colorCode': colorCode,
    'teamSuperPowers': teamSuperPowers.map((p) => p.toJson()).toList(),
    'carCompletionPercentage': carCompletionPercentage,
    'bankBalance': bankBalance,
  };

  // ── copyWith ─────────────────────────────────────────────────
  TeamModel copyWith({
    int? id,
    String? name,
    int? score,
    String? image,
    String? colorCode,
    List<TeamSuperPower>? teamSuperPowers,
    double? carCompletionPercentage,
    double? bankBalance,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      score: score ?? this.score,
      image: image ?? this.image,
      colorCode: colorCode ?? this.colorCode,
      teamSuperPowers: teamSuperPowers ?? this.teamSuperPowers,
      carCompletionPercentage:
      carCompletionPercentage ?? this.carCompletionPercentage,
      bankBalance: bankBalance ?? this.bankBalance,
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
    carCompletionPercentage,
    bankBalance,
  ];
}