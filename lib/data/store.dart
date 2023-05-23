import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final getInstance = SharedPreferences.getInstance();

class Store {
  static Future<bool> saveString(String key, String value) async {
    final preferences = await getInstance;
    return preferences.setString(key, value);
  }

  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    return await saveString(key, jsonEncode(value));
  }

  static Future<String> getString(String key,
      [String defaultValue = '']) async {
    final preferences = await getInstance;
    return preferences.getString(key) ?? defaultValue;
  }

  static Future<Map<String, dynamic>> getMap(
    String key,
  ) async {
    try {
      return jsonDecode(await getString(key));
    } on Exception catch (_) {
      return {};
    }
  }

  static Future<bool> remove(String key) async {
    final preferences = await getInstance;
    return preferences.remove(key);
  }
}
