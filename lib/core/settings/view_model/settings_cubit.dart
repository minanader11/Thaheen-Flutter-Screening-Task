import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../model/app_settings_model.dart';
import '../repo/settings_repo.dart';
import 'settings_state.dart';

@lazySingleton
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo settingsRepo;
  SettingsCubit({required this.settingsRepo}) : super(const SettingsState());

  /// Call once at app bootstrap, before runApp, so first frame is already
  /// in the right language/theme — reads straight from local storage.
  Future<void> loadSettings() async {
    final saved = await settingsRepo.getSettings();
    emit(state.copyWith(settings: saved));
  }

  Future<void> changeLanguage(AppLanguage language) async {
    final updated = state.settings.copyWith(language: language);
    emit(state.copyWith(settings: updated));
    await settingsRepo.saveSettings(updated);
  }

  Future<void> changeTheme(AppThemeMode themeMode) async {
    final updated = state.settings.copyWith(themeMode: themeMode);
    emit(state.copyWith(settings: updated));
    await settingsRepo.saveSettings(updated);
  }

  Future<void> updateLastPlaybackSpeed(double speed) async {
    final updated = state.settings.copyWith(lastPlaybackSpeed: speed);
    emit(state.copyWith(settings: updated));
    await settingsRepo.saveSettings(updated);
  }
}
