//import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/models/enum/role_enum.dart';
import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:assistantsapp/views/appointment/appointment_screen.dart';
import 'package:assistantsapp/views/conversation/conversation_screen.dart';
import 'package:assistantsapp/views/home/home_enterprise.dart';
import 'package:assistantsapp/views/home/widgets/header.dart';

import 'package:assistantsapp/views/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bottom_bar_index.dart';
//import '../../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = SharedPreferencesManager.getUserRole();
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          child: Image.asset(
            'assets/images/logo.png', // Replace with your image asset path
            fit: BoxFit.cover,
            color: const Color.fromARGB(255, 217, 173, 96),
            width: 25,
            height: 25,
            // Adjust as needed (cover, contain, etc.)
          ),
        ),
        leadingWidth: 50,
        centerTitle: true,
      ),
      body: role != Role.enterprises.name
          ? const PageRouter(
              widgetHome: HeaderHome(),
            )
          : const PageRouter(
              widgetHome: HomeEnterprise(),
            ),
      bottomNavigationBar: const MyBottomNavigatiobBar(),
    );
  }
}

class PageRouter extends StatelessWidget {
  final Widget widgetHome;
  const PageRouter({super.key, required this.widgetHome});

  @override
  Widget build(BuildContext context) {
    final bottomBarIndex = context.watch<BottomBarIndex>().selectedIndex;

    // Define a list of widgets for each page
    final List<Widget> pages = [
      widgetHome,
      const AppointmentScreen(),
      const ConversationListScreen(),
      const SettingScreen(),
    ];

    // Display the active page based on the bottom navigation index
    return IndexedStack(
      index: bottomBarIndex,
      children: pages,
    );
  }
}

class MyBottomNavigatiobBar extends StatelessWidget {
  const MyBottomNavigatiobBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarIndex>(builder: (context, bottomBarIndex, child) {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
        currentIndex: bottomBarIndex.selectedIndex,
        onTap: (index) {
          bottomBarIndex.setIndex(index);
        },
      );
    });
  }
}
