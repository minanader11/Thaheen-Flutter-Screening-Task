import 'package:equatable/equatable.dart';

enum AppLanguage { ar, en }
enum AppThemeMode { light, dark }

class AppSettingsModel extends Equatable {
  final AppLanguage language;
  final AppThemeMode themeMode;
  final double lastPlaybackSpeed;

  const AppSettingsModel({
    this.language = AppLanguage.ar,
    this.themeMode = AppThemeMode.light,
    this.lastPlaybackSpeed = 1.0,
  });

  AppSettingsModel copyWith({
    AppLanguage? language,
    AppThemeMode? themeMode,
    double? lastPlaybackSpeed,
  }) {
    return AppSettingsModel(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      lastPlaybackSpeed: lastPlaybackSpeed ?? this.lastPlaybackSpeed,
    );
  }

  Map<String, dynamic> toJson() => {
        'language': language.name,
        'themeMode': themeMode.name,
        'lastPlaybackSpeed': lastPlaybackSpeed,
      };

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      language: AppLanguage.values.firstWhere(
        (e) => e.name == json['language'],
        orElse: () => AppLanguage.ar,
      ),
      themeMode: AppThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => AppThemeMode.light,
      ),
      lastPlaybackSpeed: (json['lastPlaybackSpeed'] as num?)?.toDouble() ?? 1.0,
    );
  }

  @override
  List<Object?> get props => [language, themeMode, lastPlaybackSpeed];
}
