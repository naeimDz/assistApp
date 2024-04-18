import 'package:assistantsapp/views/authentication/login_screen.dart';
import 'package:assistantsapp/views/authentication/signup_screen.dart';
import 'package:assistantsapp/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String homeScreen = "HomeScreen";
  static const String logIn = "LogIn";
  static const String singUp = "SingUp";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return _buildRoute(const HomeScreen());
      case logIn:
        return _buildRoute(const LoginScreen());
      case singUp:
        return _buildRoute(const SingupScreen());
      default:
        return _buildRoute(const HomeScreen());
    }
  }

  static MaterialPageRoute _buildRoute(Widget builder) {
    return MaterialPageRoute(builder: (_) => builder);
  }
}
