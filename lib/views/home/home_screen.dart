//import 'package:assistantsapp/controllers/authentication_controller.dart';
import 'package:assistantsapp/views/home/widgets/header.dart';
import 'package:assistantsapp/views/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bottom_bar_index.dart';
//import '../../providers/user_provider.dart';
import '../../utils/routes/route_name_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //UserProvider userProvider = Provider.of<UserProvider>(context);
    print("home screen");
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
            icon: Icon(Icons.notifications_active),
            label: 'Notification',
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
