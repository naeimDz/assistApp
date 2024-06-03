import 'package:flutter/material.dart';

import '../utils/themes/theme_constants.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppTheme.lightTheme;
  bool _isDarkMode = false;

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    if (_isDarkMode) {
      _currentTheme = AppTheme.lightTheme;
      _isDarkMode = false;
    } else {
      _currentTheme = AppTheme.darkTheme;
      _isDarkMode = true;
    }
    notifyListeners();
  }
}
