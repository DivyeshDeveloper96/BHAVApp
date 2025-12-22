import 'dart:convert';
import 'package:bhavapp/shared/shared_pref_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared Preference Manager (Singleton)
class SharedPrefManager {
  SharedPrefManager._privateConstructor();

  static final SharedPrefManager instance =
      SharedPrefManager._privateConstructor();

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // Save String
  Future<void> saveString(SharedPrefKey key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key.name, value);
  }

  // Get String
  Future<String?> getString(SharedPrefKey key) async {
    final prefs = await _prefs;
    return prefs.getString(key.name);
  }

  // Save Bool
  Future<void> saveBool(SharedPrefKey key, bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(key.name, value);
  }

  // Get Bool
  Future<bool?> getBool(SharedPrefKey key) async {
    final prefs = await _prefs;
    return prefs.getBool(key.name);
  }

  // Save Model
  Future<void> saveModel<T>(
    SharedPrefKey key,
    T model,
    Map<String, dynamic> Function(T) toJson,
  ) async {
    final prefs = await _prefs;
    final jsonString = jsonEncode(toJson(model));
    await prefs.setString(key.name, jsonString);
  }

  // Get Model
  Future<T?> getModel<T>(
    SharedPrefKey key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(key.name);
    if (jsonString == null) return null;
    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  // Remove key
  Future<void> remove(SharedPrefKey key) async {
    final prefs = await _prefs;
    await prefs.remove(key.name);
  }

  // Clear all (use cautiously)
  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
