import 'package:assistantsapp/views/authentication/login_screen.dart';
import 'package:flutter/material.dart';

class SingupScreen extends StatefulWidget {
  static const String singUpScreen = '/singup';

  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => SingupScreenState();
}

class SingupScreenState extends State<SingupScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = true;

  void toggleObscureText() {
    obscureText = !obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Email';
                }
                return null; // here add other validator rules
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
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
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: toggleObscureText,
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                bool isValid = _validateInputs();
                if (isValid) {
                  bool canLogin = await _performSignup(context);
                  if (canLogin) {
                    print("can login");
                  } else {
                    print("somethings error");
                  }
                }
              },
              child: Text('Register'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    return _emailController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  Future<bool> _performSignup(BuildContext context) async {
    // Simulated signup process
    await Future.delayed(Duration(seconds: 2));
    return true; // Return true for successful signup, false otherwise
  }
}
