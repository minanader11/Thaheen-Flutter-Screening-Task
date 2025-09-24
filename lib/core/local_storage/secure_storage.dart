import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageHelper {
  // Internal secure storage instance with no default options
  static FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ), // No default Android options
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  @visibleForTesting
  static void setStorage(FlutterSecureStorage storage) {
    _storage = storage;
  }

  /// Save any supported type (String, int, double, bool, List<String>, Map)
  static Future<void> write<T>({required String key, required T value}) async {
    String stringValue;

    if (value is String) {
      stringValue = value;
    } else if (value is int || value is double || value is bool) {
      stringValue = value.toString();
    } else if (value is List<String>) {
      stringValue = jsonEncode(value);
    } else if (value is Map) {
      stringValue = jsonEncode(value);
    } else {
      throw UnsupportedError("Unsupported type: ${value.runtimeType}");
    }

    await _storage.write(key: key, value: stringValue);
  }

  /// Read a value of expected type
  static Future<T?> read<T>({required String key}) async {
    final stringValue = await _storage.read(key: key);
    if (stringValue == null) return null;

    try {
      if (T == String) return stringValue as T;
      if (T == int) return int.parse(stringValue) as T;
      if (T == double) return double.parse(stringValue) as T;
      if (T == bool) return (stringValue.toLowerCase() == 'true') as T;
      if (T == List<String>) {
        return List<String>.from(jsonDecode(stringValue)) as T;
      }
      if (T == Map<String, dynamic>) {
        return jsonDecode(stringValue) as T;
      }
    } catch (e) {
      throw FormatException("Failed to parse value for key '$key': $e");
    }

    throw UnsupportedError("Unsupported type: $T");
  }

  /// Delete a specific key
  static Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Delete all keys
  static Future<void> clear() async {
    await _storage.deleteAll();
  }

  /// Check if a key exists
  static Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }

  /// Read all key-value pairs
  static Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  static Future<void> clearSecureStorageOnFirstInstall() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstInstall = prefs.getBool('is_first_install') ?? true;

    if (isFirstInstall) {
      await SecureStorageHelper.clear(); // wipe secure storage
      await prefs.setBool('is_first_install', false);
    }
  }
}
