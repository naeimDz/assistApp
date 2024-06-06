import 'package:assistantsapp/providers/dark_mode.dart';
import 'package:assistantsapp/services/firestore_service.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/sharedwidgets/circle_avatar.dart';
import 'package:assistantsapp/views/sharedwidgets/headline_with_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/shared_preferences_manager.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var name = FirestoreService().auth.currentUser?.displayName;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture with Edit Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  circleAvatar(
                      "appstartup-383e8.appspot.com/user_profile_images/avatar-place.png",
                      name,
                      radius: 80),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          //  FirestoreService().updateUserPhoto(imageFile);

                          print("Edit Picture");
                        } // Implement image picking
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const HeadlineRow(
            headline: "Account",
            subtitle: "keep your information update",
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text('personal data'),
            leading: const Icon(Icons.data_object),
            onTap: () {
              Navigator.pushNamed(context, RouteNameStrings.editPersonalScreen);
            },
          ),
          ListTile(
            title: const Text('Contact data'),
            leading: const Icon(Icons.contact_page),
            onTap: () {
              Navigator.pushNamed(context, RouteNameStrings.editContactScreen);
            },
          ),
          ListTile(
            //trailing: Icon(Icons.arrow_forward),
            title: const Text('im a assistant'),
            leading: const Icon(Icons.assistant),
            onTap: () {
              String userRole = SharedPreferencesManager.getUserRole();

              if ("clients" == userRole) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Alert'),
                      content: Text('you dont have access '),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.pushNamed(
                    context, RouteNameStrings.editAssistantProfileView);
              }
            },
          ),
          const Divider(),
          const HeadlineRow(
            headline: "Application settings",
            subtitle: "Notification Settings",
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text('Push Notifications'),
            value: true, // Replace with actual value
            onChanged: (value) {
              // Update push notification setting
            },
          ),
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, child) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                },
              );
            },
          ),

          const Divider(),
          const HeadlineRow(
            headline: "Privacy",
            subtitle: "protect your account",
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text('delete your data'),
            leading: const Icon(Icons.delete),
            onTap: () {
              // Navigate to edit profile screen
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.data_usage),
            onTap: () {
              Navigator.pushNamed(
                  context, RouteNameStrings.privacyPolicyScreen);
            },
          ),
          ListTile(
            title: const Text("Terms and Conditions"),
            subtitle: const Text("legal, terms and conditions"),
            leading: const Icon(Icons.file_copy),
            onTap: () {
              Navigator.pushNamed(context, RouteNameStrings.termsConditions);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              // Perform logout action
            },
          ),
        ],
      ),
    );
  }
}
