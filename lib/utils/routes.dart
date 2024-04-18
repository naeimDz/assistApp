import 'package:flutter/material.dart';

import '../views/authentication/login_screen.dart';
import '../views/authentication/signup_screen.dart';
import '../views/home/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.logInScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case HomeScreen.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case SingupScreen.singUpScreen:
        return MaterialPageRoute(builder: (context) => const SingupScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
