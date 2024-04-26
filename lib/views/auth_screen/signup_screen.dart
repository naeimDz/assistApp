import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import '../../controllers/authentication_controller.dart';
import '../../mixins/snack_mixin.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/constants/app_strings.dart';
import 'components/msg_welcome.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});
  @override
  SingupScreenState createState() => SingupScreenState();
}

class SingupScreenState extends State<SingupScreen> with SnackMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthenticationController _authController = AuthenticationController();

  bool obscureText = true;
  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Wrap(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.instructionMsgSingupScreen,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.popAndPushNamed(context, RouteNameStrings.logIn),
                child: Text(" Login".tr()),
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
                'Register'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  // String userName = _usernameController.text.trim();
                  var res = await _authController.signUpWithEmailAndPassword(
                      email, password);
                  print(res);
                  if (res != null && mounted) {
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
      ]),
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Wrap(
          spacing: 10,
          children: [
            MsgWelcome(
                messageWelcome: AppStrings.messageWelcomeSingupScreen,
                headlineWelcome: AppStrings.headlineWelcomeSingupScreen),
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
                        return 'Please enter your Email'.tr();
                      }
                      return null; // here add other validator rules
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Usernamel'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username'.tr();
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
