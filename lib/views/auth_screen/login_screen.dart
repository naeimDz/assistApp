import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/services/determine_user.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import '../../mixins/snack_mixin.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/constants/app_strings.dart';
import 'components/msg_welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SnackMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscureText = true;
  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.instructionMsgLoginScreen,
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.popAndPushNamed(
                      context, RouteNameStrings.signUp),
                  child: Text(" Register".tr()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  'Log in'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    await AuthenticationController().signin(email, password);

                    if (mounted) {
                      DetermineUser().determineUserRole("email", email: email);

                      showSuccess(context, AppStrings.loginSuccessMessage.tr());
                      Navigator.pushReplacementNamed(
                          context, RouteNameStrings.homeScreen);
                    } else {
                      showError(context, AppStrings.loginErrorMessage.tr());
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            MsgWelcome(
              messageWelcome: AppStrings.messageWelcomeloginScreen,
              headlineWelcome: AppStrings.headlineWelcomeLoginScreen,
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email'.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () => toggleObscureText(),
                        child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      labelText: 'Password'.tr(),
                    ),
                    obscureText: obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password'.tr();
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
