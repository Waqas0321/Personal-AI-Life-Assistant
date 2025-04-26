import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  /// Method to save a String value
  static Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /// Method to get a String value
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Remove a string from SharedPreferences
  static Future<void> removeData(dynamic key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// Method to save an int value
  static Future<void> setInt(String key, int? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value!);
  }

  /// Method to get an int value
  static Future<int?> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  /// Method to save a bool value
  static Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  /// Method to get a bool value
  static Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  /// Method to save a double value
  static Future<void> setDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  /// Method to get a double value
  static Future<double?> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }
}
