import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/appointment/appoint_screen.dart';
import 'package:assistantsapp/views/home/home_screen.dart';
import 'package:assistantsapp/views/setting/privacy/privacy_and_terms_screen.dart';
import 'package:assistantsapp/views/setting/privacy/terms_conditions.dart';
import 'package:flutter/material.dart';

import '../../views/auth_screen/login_screen.dart';
import '../../views/auth_screen/signup_screen.dart';
import '../../views/profile_detail/assistant_detail_screen.dart';
import '../../views/setting/edit_profile/edit_info_contact_screen.dart';
import '../../views/setting/edit_profile/edit_info_personal_screen.dart';
import '../../views/setting/setting_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNameStrings.homeScreen:
        return _buildRoute(const HomeScreen());
      case RouteNameStrings.logIn:
        return _buildRoute(const LoginScreen());
      case RouteNameStrings.signUp:
        return _buildRoute(const SignupScreen());
      case RouteNameStrings.settingScreen:
        return _buildRoute(const SettingScreen());
      case RouteNameStrings.assistantDetailScreen:
        return _buildRoute(const AssistantDetailScreen());
      case RouteNameStrings.editPersonalScreen:
        return _buildRoute(const EditInfoScreen());
      case RouteNameStrings.editContactScreen:
        return _buildRoute(const EditContactScreen());
      case RouteNameStrings.appointScreen:
        return _buildRoute(const AppointScreen());
      case RouteNameStrings.privacyPolicyScreen:
        return _buildRoute(const PrivacyPolicyScreen());
      case RouteNameStrings.termsConditions:
        return _buildRoute(const TermsConditions());

      default:
        return _buildRoute(const HomeScreen());
    }
  }

  static MaterialPageRoute _buildRoute(Widget builder) {
    return MaterialPageRoute(builder: (_) => builder);
  }
}
