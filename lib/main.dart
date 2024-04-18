import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'utils/routes/routing.dart';
import 'utils/themes/theme_constants.dart';
import 'views/auth_screen/login_screen.dart';
import 'views/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: AppTheme.lightTheme,
    initialRoute: FirebaseAuth.instance.currentUser != null
        ? HomeScreen.homeScreen
        : LoginScreen.logInScreen,
    onGenerateRoute: Routes.generateRoute,
    //home: LoginScreen(),
  ));
}
