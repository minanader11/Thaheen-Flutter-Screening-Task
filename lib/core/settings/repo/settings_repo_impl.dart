import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../cache/cache_helper.dart';
import '../../cache/cache_keys.dart';
import '../model/app_settings_model.dart';
import 'settings_repo.dart';

@LazySingleton(as: SettingsRepo)
class SettingsRepoImpl implements SettingsRepo {
  @override
  Future<AppSettingsModel> getSettings() async {
    final raw = CacheHelper.getData<String>(key: CacheKeys.appSettings);
    if (raw == null) return const AppSettingsModel(); // first launch defaults
    try {
      return AppSettingsModel.fromJson(jsonDecode(raw));
    } catch (_) {
      return const AppSettingsModel(); // corrupt value -> fall back safely
    }
  }

  @override
  Future<void> saveSettings(AppSettingsModel settings) async {
    await CacheHelper.saveData(
      key: CacheKeys.appSettings,
      value: jsonEncode(settings.toJson()),
    );
  }
}
