import 'package:assistantsapp/models/client.dart';
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
                          value: 'clients',
                          child: Text('Client'),
                        ),
                        DropdownMenuItem(
                          value: 'assistants',
                          child: Text('Assistant'),
                        ),
                        DropdownMenuItem(
                          value: 'enterprises',
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
      final AuthService authController = AuthService();
      var user =
          await authController.signUpWithEmailAndPassword(email, password);

      if (mounted) {
        user.updateDisplayName(userName);
        FirestoreService firestoreService = FirestoreService();
        showSuccess(context, AppStrings.loginSuccessMessage.tr());
        SharedPreferencesManager.setUserRole(_selectedType!);
        var dataUser = {
          "id": user.uid,
          "email": email,
          "role": Role.assistants.name,
          "userName": userName,
          "joinDate": DateTime.now(),
          "isValidated": false,
          'assistants': [],
          'clients': [],
          'appointments': [],
        };
        switch (_selectedType) {
          case "clients":
            Client client = Client(
                id: user.uid,
                email: email,
                userName: userName,
                role: Role.clients,
                joinDate: DateTime.now());
            await firestoreService.createDocument(
                "clients", user.uid, client.toJson());
            Navigator.pushReplacementNamed(
                context, RouteNameStrings.homeScreen);
            break;
          case "assistants":
            await firestoreService.createDocument(
                "assistants", user.uid, dataUser);

            Navigator.pushReplacementNamed(
                context, RouteNameStrings.editAssistantProfileView);
            break;
          case "enterprises":
            Enterprise newEnterprise = Enterprise(
                id: user.uid,
                enterpriseName: userName,
                email: email,
                role: Role.enterprises,
                joinDate: DateTime.now());
            await firestoreService.createDocument(
                "enterprises", user.uid, newEnterprise.toJson());

            Navigator.pushReplacementNamed(context, RouteNameStrings.homeScreen,
                arguments: Role.enterprises.name);

            break;
        }
      } else {
        showError(context, AppStrings.loginErrorMessage.tr());
      }
    }
  }
}
