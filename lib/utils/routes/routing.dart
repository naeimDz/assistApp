import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../views/auth_screen/login_screen.dart';
import '../../views/auth_screen/signup_screen.dart';
import '../../views/profile/assistant/assistant_profile_screen.dart';
import '../../views/setting/setting_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNameStrings.homeScreen:
        return _buildRoute(const HomeScreen());
      case RouteNameStrings.logIn:
        return _buildRoute(const LoginScreen());
      case RouteNameStrings.signUp:
        return _buildRoute(const SingupScreen());
      case RouteNameStrings.settingScreen:
        return _buildRoute(const SettingScreen());
      case RouteNameStrings.assistantProfileScreen:
        return _buildRoute(const AssistantProfileScreen());
      default:
        return _buildRoute(const HomeScreen());
    }
  }

  static MaterialPageRoute _buildRoute(Widget builder) {
    return MaterialPageRoute(builder: (_) => builder);
  }
}
