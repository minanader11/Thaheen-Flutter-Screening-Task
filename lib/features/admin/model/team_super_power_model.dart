import 'package:equatable/equatable.dart';

// ─────────────────────────────────────────────────────────────────
// Enums — mirror C# SuperPowerType & SuperPowerStatus exactly
// ─────────────────────────────────────────────────────────────────

enum SuperPowerType {
  taxCollector,
  doublePoints,
  minus,
  freezer,
  dice,
  reActivation;

  /// Serialize to the string expected by the backend.
  String toJson() => switch (this) {
    SuperPowerType.taxCollector => 'TaxCollector',
    SuperPowerType.doublePoints => 'DoublePoints',
    SuperPowerType.minus => 'Minus',
    SuperPowerType.freezer => 'Freezer',
    SuperPowerType.dice => 'Dice',
    SuperPowerType.reActivation => 'ReActivation',
  };

  /// Parse the string received from the backend.
  static SuperPowerType fromJson(String value) => switch (value) {
    'TaxCollector' => SuperPowerType.taxCollector,
    'DoublePoints' => SuperPowerType.doublePoints,
    'Minus' => SuperPowerType.minus,
    'Freezer' => SuperPowerType.freezer,
    'Dice' => SuperPowerType.dice,
    'ReActivation' => SuperPowerType.reActivation,
    _ => throw ArgumentError('Unknown SuperPowerType: $value'),
  };

  /// Safe parser that returns null for unknown values.
  static SuperPowerType? tryParse(String? value) => switch (value) {
    'TaxCollector' => SuperPowerType.taxCollector,
    'DoublePoints' => SuperPowerType.doublePoints,
    'Minus' => SuperPowerType.minus,
    'Freezer' => SuperPowerType.freezer,
    'Dice' => SuperPowerType.dice,
    'ReActivation' => SuperPowerType.reActivation,
    _ => null,
  };

  /// Human-readable label used in the UI.
  String get label => switch (this) {
    SuperPowerType.taxCollector => 'Tax Collector',
    SuperPowerType.doublePoints => 'Double Points',
    SuperPowerType.minus => 'Minus',
    SuperPowerType.freezer => 'Freezer',
    SuperPowerType.dice => 'Dice',
    SuperPowerType.reActivation => 'Re-Activation',
  };
}

enum SuperPowerStatus {
  notUsedYet,
  activated,
  deactivated;

  String toJson() => switch (this) {
        SuperPowerStatus.notUsedYet => 'NotUsedYet',
        SuperPowerStatus.activated => 'Activated',
        SuperPowerStatus.deactivated => 'Deactivated',
      };

  static SuperPowerStatus fromJson(String value) => switch (value) {
        'NotUsedYet' => SuperPowerStatus.notUsedYet,
        'Activated' => SuperPowerStatus.activated,
        'Deactivated' => SuperPowerStatus.deactivated,
        _ => throw ArgumentError('Unknown SuperPowerStatus: $value'),
      };
}

// ─────────────────────────────────────────────────────────────────
// TeamSuperPower model
// ─────────────────────────────────────────────────────────────────

class TeamSuperPower extends Equatable {
  final int id;
  final int teamId;
  final SuperPowerType type;
  final SuperPowerStatus status;
  final DateTime? activatedAt;
  final DateTime? deactivatedAt;
  final int? targetTeamId;
  final String? imageBase64;

  const TeamSuperPower({
    required this.id,
    required this.teamId,
    required this.type,
    required this.status,
    this.activatedAt,
    this.deactivatedAt,
    this.targetTeamId,
    this.imageBase64,
  });

  // ── Convenience getters ──────────────────────────────────────
  bool get isActive => status == SuperPowerStatus.activated;
  bool get isUsed => status == SuperPowerStatus.deactivated;
  bool get isAvailable => status == SuperPowerStatus.notUsedYet;

  // ── fromJson ─────────────────────────────────────────────────
  factory TeamSuperPower.fromJson(Map<String, dynamic> json) {
    return TeamSuperPower(
      id: json['id'] as int,
      teamId: json['teamId'] as int,
      type: SuperPowerType.fromJson(json['type'] as String),
      status: SuperPowerStatus.fromJson(json['status'] as String),
      activatedAt: json['activatedAt'] != null
          ? DateTime.parse(json['activatedAt'] as String)
          : null,
      deactivatedAt: json['deactivatedAt'] != null
          ? DateTime.parse(json['deactivatedAt'] as String)
          : null,
      targetTeamId: json['targetTeamId'] as int?,
      imageBase64: json['imageBase64'] as String?,
    );
  }

  // ── toJson ───────────────────────────────────────────────────
  Map<String, dynamic> toJson() => {
        'id': id,
        'teamId': teamId,
        'type': type.toJson(),
        'status': status.toJson(),
        'activatedAt': activatedAt?.toIso8601String(),
        'deactivatedAt': deactivatedAt?.toIso8601String(),
        'targetTeamId': targetTeamId,
        'imageBase64': imageBase64,
      };

  // ── copyWith ─────────────────────────────────────────────────
  TeamSuperPower copyWith({
    int? id,
    int? teamId,
    SuperPowerType? type,
    SuperPowerStatus? status,
    DateTime? activatedAt,
    DateTime? deactivatedAt,
    int? targetTeamId,
    String? imageBase64,
  }) {
    return TeamSuperPower(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      type: type ?? this.type,
      status: status ?? this.status,
      activatedAt: activatedAt ?? this.activatedAt,
      deactivatedAt: deactivatedAt ?? this.deactivatedAt,
      targetTeamId: targetTeamId ?? this.targetTeamId,
      imageBase64: imageBase64 ?? this.imageBase64,
    );
  }

  @override
  List<Object?> get props => [
        id,
        teamId,
        type,
        status,
        activatedAt,
        deactivatedAt,
        targetTeamId,
        imageBase64,
      ];
}
