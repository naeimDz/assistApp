//import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/views/home/widgets/header.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/route_name_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.logo_dev,
          size: 50,
          color: Colors.pink,
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () {
              Navigator.pushReplacementNamed(context, RouteNameStrings.logIn);
              //_authController.signOut();
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, RouteNameStrings.settingScreen);
            },
          ),
        ],
        centerTitle: true,
      ),
      body: HeaderHome(),
      bottomNavigationBar: const MyBottomNavigatiobBar(),
    );
  }
}

class MyBottomNavigatiobBar extends StatefulWidget {
  const MyBottomNavigatiobBar({super.key});

  @override
  State<MyBottomNavigatiobBar> createState() => _MyBottomNavigatiobBarState();
}

class _MyBottomNavigatiobBarState extends State<MyBottomNavigatiobBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
