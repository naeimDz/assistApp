//import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/views/home/widgets/header.dart';
import 'package:assistantsapp/views/setting/setting_screen.dart';
import 'package:assistantsapp/views/testview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bottom_bar_index.dart';
//import '../../providers/user_provider.dart';

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
          /*Consumer<AuthenticationProvider>(builder: (context, authProvider, _) {
            return IconButton(
              icon: const Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                //  _authController.signOut();
                authProvider.signOut();
                Navigator.pushReplacementNamed(context, RouteNameStrings.logIn);
              },
            );
          }),*/
        ],
        centerTitle: true,
      ),
      body: const PageRouter(),
      bottomNavigationBar: const MyBottomNavigatiobBar(),
    );
  }
}

class PageRouter extends StatelessWidget {
  const PageRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomBarIndex = context.watch<BottomBarIndex>().selectedIndex;

    // Define a list of widgets for each page
    final List<Widget> pages = [
      const HeaderHome(),
      const TestView(),
      const SizedBox(),
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
