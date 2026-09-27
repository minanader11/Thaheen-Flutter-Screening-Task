import '../model/app_settings_model.dart';

abstract class SettingsRepo {
  Future<AppSettingsModel> getSettings();
  Future<void> saveSettings(AppSettingsModel settings);
}
