import 'package:assistantsapp/views/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../views/auth_screen/login_screen.dart';
import '../../views/auth_screen/signup_screen.dart';

class Routes {
  static const String homeScreen = "HomeScreen";
  static const String logIn = "LogIn";
  static const String singUp = "SingUp";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return _buildRoute(HomeScreen());
      case logIn:
        return _buildRoute(const LoginScreen());
      case singUp:
        return _buildRoute(const SingupScreen());
      default:
        return _buildRoute(HomeScreen());
    }
  }

  static MaterialPageRoute _buildRoute(Widget builder) {
    return MaterialPageRoute(builder: (_) => builder);
  }
}
