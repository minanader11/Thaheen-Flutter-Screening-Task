import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// Hive wrapper providing typed persistence for the application and lesson progress.
@lazySingleton
class CacheHelper {
  static Box? _box;
  static const String boxName = 'app_cache';

  /// Initializes Hive and opens the app cache box.
  /// Typically called during bootstrap before runApp.
  static Future<void> init() async {
    if (_box != null && _box!.isOpen) return;

    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      try {
        await Hive.initFlutter();
      } catch (_) {
        // Fallback for non-Flutter test runner environments
        final tempDir = Directory.systemTemp.createTempSync('hive_cache_');
        Hive.init(tempDir.path);
      }
    }

    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox(boxName);
    } else {
      _box = Hive.box(boxName);
    }
  }

  /// Visible only for testing to allow injecting a mock Hive box.
  @visibleForTesting
  static void setMockBox(Box box) {
    _box = box;
  }

  static Box get _instance {
    if (_box == null || !_box!.isOpen) {
      throw StateError(
        'CacheHelper has not been initialized. Call await CacheHelper.init() in main() before accessing cache.',
      );
    }
    return _box!;
  }

  /// Supports [bool], [String], [int], [double], and [List<String>].
  static Future<bool> saveData({
    required String key,
    required Object value,
  }) async {
    if (value is! bool &&
        value is! String &&
        value is! int &&
        value is! double &&
        value is! List<String>) {
      throw ArgumentError(
        'Unsupported type: ${value.runtimeType}. '
        'Only bool, String, int, double, and List<String> are supported.',
      );
    }

    await _instance.put(key, value);
    return true;
  }

  /// Returns `null` if the key does not exist or type does not match.
  static T? getData<T>({
    required String key,
  }) {
    if (!_instance.containsKey(key)) return null;
    final value = _instance.get(key);

    if (value is List) {
      try {
        final list = value.cast<String>().toList();
        if (list is T) return list as T;
      } catch (_) {}
    }

    if (value is T) {
      return value;
    }

    return null;
  }

  /// Checks whether a [key] exists in the cache.
  static bool containsKey({
    required String key,
  }) {
    return _instance.containsKey(key);
  }

  /// Removes a single entry from the cache by its [key].
  static Future<bool> removeData({
    required String key,
  }) async {
    await _instance.delete(key);
    return true;
  }

  /// Clears all cached data in the box.
  static Future<bool> clearAll() async {
    await _instance.clear();
    return true;
  }
}
