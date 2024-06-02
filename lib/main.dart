import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/controllers/enterprise/enterprise_provider.dart';

import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'controllers/assistant/assistant_provider.dart';
import 'controllers/client/client_provider.dart';

import 'providers/bottom_bar_index.dart';
import 'utils/routes/routing.dart';
import 'utils/themes/theme_constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  SharedPreferencesManager();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomBarIndex()),
        ChangeNotifierProvider(create: (context) => AssistantProvider()),
        ChangeNotifierProvider(create: (context) => ClientProvider()),
        ChangeNotifierProvider(create: (context) => EnterpriseProvider()),
        ChangeNotifierProvider(create: (context) => AuthenticationController()),

        // Add more providers if needed
      ],
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path:
              'assets/translations', // <-- change the path of the translation files
          fallbackLocale: const Locale('en'),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? RouteNameStrings.homeScreen
          : RouteNameStrings.signUp,
      onGenerateRoute: Routes.generateRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
