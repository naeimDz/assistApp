import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/home/home_screen.dart';
import 'package:assistantsapp/views/setting/privacy_and_terms_screen.dart';
import 'package:assistantsapp/views/setting/terms_conditions.dart';
import 'package:flutter/material.dart';

import '../../views/auth_screen/login_screen.dart';
import '../../views/auth_screen/signup_screen.dart';
import '../../views/profile_detail/profile_detail_screen.dart';
import '../../views/setting/profile_edit/user/user_profile_view.dart';
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
      case RouteNameStrings.profileDetailScreen:
        return _buildRoute(const ProfileDetailScreen());
      case RouteNameStrings.editProfileView:
        return _buildRoute(EditProfileView());
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
