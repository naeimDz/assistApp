import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:flutter/material.dart';

import '../utils/themes/theme_constants.dart';

class ThemeNotifier extends ChangeNotifier {
  late ThemeData _currentTheme;
  late bool _isDarkMode;

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;
  ThemeNotifier() {
    _isDarkMode = SharedPreferencesManager.getDarkMode();
    _currentTheme = _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  }
  void toggleTheme() {
    if (_isDarkMode) {
      _currentTheme = AppTheme.lightTheme;
      _isDarkMode = false;
      SharedPreferencesManager.setDarkMode(false);
    } else {
      _currentTheme = AppTheme.darkTheme;
      _isDarkMode = true;
      SharedPreferencesManager.setDarkMode(true);
    }
    notifyListeners();
  }
}
