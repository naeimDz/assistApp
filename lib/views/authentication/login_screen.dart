import 'package:assistantsapp/utils/constants/app_strings.dart';
import 'package:assistantsapp/views/authentication/components/msg_welcome.dart';
import 'package:assistantsapp/views/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import '../../controllers/authentication_controller.dart';

class LoginScreen extends StatefulWidget {
  static const String logInScreen = 'login';
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final AuthenticationController _authController = AuthenticationController();

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
      bottomNavigationBar: Wrap(children: [
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
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const SingupScreen()),
                  );
                },
                child: Text(" Register:"),
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
              child: Text('Log in'),
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                var res = await _authController.signInWithEmailAndPassword(
                    email, password);
                print("___________________________");
                print(res);
              },
            ),
          ),
        ),
      ]),
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.turn_left),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            MsgWelcome(
              messageWelcome: "${AppStrings.messageWelcomeloginScreen}",
              headlineWelcome: "${AppStrings.headlineWelcomeLoginScreen}",
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
                      labelText: 'Phone,Username or Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
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
                      labelText: 'Password',
                    ),
                    obscureText: obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
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
