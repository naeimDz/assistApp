/*import 'package:bac_etudiants/core/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData selectedTheme=AppTheme.darkTheme;
  late SharedPreferences prefs;
  ThemeProvider({bool isDark = true}) {
    this.selectedTheme = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }


  Future<void> changeTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (selectedTheme == AppTheme.lightTheme) {
      selectedTheme = AppTheme.lightTheme;
      await prefs.setBool("isDark", false);
    } else {
      selectedTheme = AppTheme.darkTheme;
      await prefs.setBool("isDark", true);
    }
//notifying all the listeners(consumers) about the change.
    notifyListeners();
  }
}
*/