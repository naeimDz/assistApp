/*import 'package:assistantsapp/providers/authentication_provider.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'controllers/authentication_controller.dart';
import 'providers/bottom_bar_index.dart';
import 'providers/list_assistant.dart';
import 'providers/user_provider.dart';
import 'utils/routes/routing.dart';
import 'utils/themes/theme_constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BottomBarIndex()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(
        create: (context) => AuthenticationProvider(AuthenticationController()),
      ),
      ChangeNotifierProvider(
        create: (context) => ListAssistant(),
      )
      // Add more providers if needed
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? RouteNameStrings.homeScreen
          : RouteNameStrings.logIn,
      onGenerateRoute: Routes.generateRoute,
    ),
  ));
}
*/