import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'utils/routes/routing.dart';
import 'utils/themes/theme_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    initialRoute: FirebaseAuth.instance.currentUser != null
        ? RouteNameStrings.homeScreen
        : RouteNameStrings.logIn,
    onGenerateRoute: Routes.generateRoute,
    //home: LoginScreen(),
  ));
}
