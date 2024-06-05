//import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/models/enum/role_enum.dart';
import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
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
    var role = SharedPreferencesManager.getUserRole();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.logo_dev,
          size: 50,
          color: Colors.pink,
        ),
        leadingWidth: 100,
        actions: [
          Consumer<AuthService>(builder: (context, authProvider, _) {
            return IconButton(
              icon: const Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                authProvider.signout();
                Navigator.pushReplacementNamed(context, RouteNameStrings.logIn);
              },
            );
          }),
        ],
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
