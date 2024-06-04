import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _prefs;

  SharedPreferencesManager._internal(); // Private constructor for singleton pattern

  factory SharedPreferencesManager() {
    return _instance;
  }

  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Method to set user theme preference
  static Future<void> setDarkMode(bool themeMode) async {
    await _prefs.setBool('darkMode', themeMode);
  }

  // Method to get user theme preference
  static bool getDarkMode() {
    return _prefs.getBool('darkMode') ?? false;
  }

  // Method to set notification preference
  static Future<void> setNotificationEnabled(bool isEnabled) async {
    await _prefs.setBool('notificationEnabled', isEnabled);
  }

  // Method to get notification preference
  static bool getNotificationEnabled() {
    return _prefs.getBool('notificationEnabled') ?? false;
  }

  // Method to set user role
  static Future<void> setUserRole(String role) async {
    await _prefs.setString('userRole', role);
  }

  // Method to get user role (with default value)
  static String getUserRole() {
    return _prefs.getString('userRole') ?? 'user';
  }
}
