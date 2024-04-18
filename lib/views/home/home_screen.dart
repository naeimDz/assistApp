import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';

import '../auth_screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const String homeScreen = "HomeScreen";
  final AuthenticationController _authController = AuthenticationController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen()), // Navigate to login screen
                  );
                  _authController.signOut();
                },
                icon: Icon(Icons.exit_to_app_rounded))
          ],
          centerTitle: true,
          title: Text("title"),
        ),
        body: Column(
          children: [
            ListTile(
              title: Text("name"),
              subtitle: Text("lastname description"),
            ),
            ListTile(
              title: Text("name2"),
              subtitle: Text("lastname2 description"),
            ),
            ListTile(
              title: Text("name3"),
              subtitle: Text("lastname3 description"),
            )
          ],
        ),
      ),
    );
  }
}
