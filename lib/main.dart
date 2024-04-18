import 'package:assistantsapp/utils/themes/theme_constants.dart';
import 'package:assistantsapp/views/authentication/login_screen.dart';
import 'package:assistantsapp/views/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: AppTheme.darkTheme,
    initialRoute: FirebaseAuth.instance.currentUser != null
        ? HomeScreen.homeScreen
        : LoginScreen.logInScreen,
    home: const LoginScreen(),
  ));
}
