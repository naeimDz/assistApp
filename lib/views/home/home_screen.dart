import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/views/home/widgets/header.dart';
import 'package:flutter/material.dart';
import '../auth_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthenticationController _authController = AuthenticationController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        ),
        body: HeaderHome(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
