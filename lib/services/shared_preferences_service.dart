import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final keyUsername = 'keyUsername';
  static final keyPassword = 'keyPassword';

  static setUsername(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUsername, value);
  }

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername);
  }

  static setPassword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyPassword, value);
  }

  static Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPassword);
  }
}
