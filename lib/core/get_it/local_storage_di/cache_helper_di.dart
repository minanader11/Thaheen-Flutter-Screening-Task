import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
@lazySingleton
class CacheHelper {
  static late SharedPreferences _prefs;

  /// Initializes the SharedPreferences instance.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Visible only for testing to allow injecting mock SharedPreferences.
  @visibleForTesting
  static void setMockPrefs(SharedPreferences prefs) {
    _prefs = prefs;
  }

  /// Supports [bool], [String], [int], [double], and [List<String>].
  static Future<bool> saveData({
    required String key,
    required Object value,
  }) async {
    if (value is bool) return _prefs.setBool(key, value);
    if (value is String) return _prefs.setString(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    if (value is List<String>) return _prefs.setStringList(key, value);

    throw ArgumentError(
      'Unsupported type: ${value.runtimeType}. '
          'Only bool, String, int, double, and List<String> are supported.',
    );
  }

  /// Returns `null` if the key does not exist.
  static T? getData<T>({
    required String key,
  }) {
    final value = _prefs.get(key);
    return value is T ? value : null;
  }

  /// Removes a single entry from the cache by its [key].
  static Future<bool> removeData({
    required String key,
  }) {
    return _prefs.remove(key);
  }

  /// Clears all cached data.
  static Future<bool> clearAll() {
    return _prefs.clear();
  }
}
