import 'package:assistantsapp/controllers/enterprise/enterprise_provider.dart';
import 'package:assistantsapp/models/enterprise.dart';
import 'package:assistantsapp/models/enum/role_enum.dart';
import 'package:assistantsapp/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/shared_preferences_manager.dart';
import '../../utils/constants/app_strings.dart';
import 'components/msg_welcome.dart';
import '../../mixins/snack_mixin.dart';
import '../../controllers/authentication_controller.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SnackMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedType;
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                  onTap: () => Navigator.popAndPushNamed(
                      context, RouteNameStrings.logIn),
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
                  _signUp();
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            children: [
              MsgWelcome(
                messageWelcome: AppStrings.messageWelcomeSingupScreen,
                headlineWelcome: AppStrings.headlineWelcomeSingupScreen,
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
                          return 'Please enter your Email'.tr();
                        }
                        return null; // here add other validator rules
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Display Name'.tr();
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
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      decoration: InputDecoration(
                        labelText: 'Account Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'User',
                          child: Text('User'),
                        ),
                        DropdownMenuItem(
                          value: 'Assistant',
                          child: Text('Assistant'),
                        ),
                        DropdownMenuItem(
                          value: 'Enterprise',
                          child: Text('Enterprise'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select account type';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String userName = _usernameController.text.trim();
      final AuthenticationController authController =
          AuthenticationController();
      var user =
          await authController.signUpWithEmailAndPassword(email, password);
      var dataUser = {
        "email": email,
        "role": _selectedType,
        "firstName": userName,
        "joinDate": DateTime.now()
      };
      if (mounted) {
        showSuccess(context, AppStrings.loginSuccessMessage.tr());
        FirestoreService firestoreService = FirestoreService();

        SharedPreferencesManager.setUserRole(_selectedType!);
        switch (_selectedType) {
          case "User":
            await firestoreService.createDocument(
                "usersTest", user.uid, dataUser);

            Navigator.pushReplacementNamed(
                context, RouteNameStrings.homeScreen);
            break;
          case "Assistant":
            await firestoreService.createDocument(
                "assistants", user.uid, dataUser);
            Navigator.pushReplacementNamed(
                context, RouteNameStrings.assistantDetailScreen);
            break;
          case "Enterprise":
            Enterprise newData = Enterprise(
                id: user.uid,
                enterpriseName: userName,
                email: email,
                role: Role.enterprise);
            EnterpriseProvider().addEnterprise(newData);
            /*await firestoreService.createDocument(
                "enterprises", user.uid, dataUser);*/
            Navigator.pushReplacementNamed(
                context, RouteNameStrings.homeScreen);
            break;
        }
      } else {
        showError(context, AppStrings.loginErrorMessage.tr());
      }
    }
  }
}
