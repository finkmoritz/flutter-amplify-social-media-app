import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final keyUsername = 'keyUsername';
  static final keyPassword = 'keyPassword';
  static final keyThemeMode = 'keyDarkTheme';

  static setUsername(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUsername, value);
  }

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername) ?? '';
  }

  static setPassword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyPassword, value);
  }

  static Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPassword) ?? '';
  }

  static setThemeMode(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyThemeMode, themeMode.index);
  }

  static Future<ThemeMode> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeModeIndex = prefs.getInt(keyThemeMode) ?? ThemeMode.system.index;
    return ThemeMode.values[themeModeIndex];
  }
}
