import 'package:assistantsapp/controllers/authentication_controller.dart';
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
                      FirestoreService().auth.currentUser?.photoURL, name,
                      radius: 80),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          FirestoreService().updateUserPhoto();

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
          const ListTile(
            title: Text('Shared applications'),
            leading: Icon(Icons.share_rounded),
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
            title: const Text('Delete your data'),
            leading: const Icon(Icons.delete,
                color: Colors.red), // Emphasize warning
            onTap: () async {
              // Prompt user for confirmation
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Warning: This action is permanent'),
                  content: const Text(
                      'Are you sure you want to delete your data? This cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false), // Cancel
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true), // Confirm
                      child: Text(
                        'Delete',
                        style:
                            TextStyle(color: Colors.red), // Emphasize warning
                      ),
                    ),
                  ],
                ),
              );

              if (confirmed ?? false) {
                // Use null-safe operator for default value
                try {
                  await AuthService().deleteAccount();
                  // Handle successful deletion (e.g., navigate to login screen)
                  Navigator.of(context).pushReplacementNamed(
                      RouteNameStrings.signUp); // Replace with your login route
                  print('User data deleted successfully.');
                } catch (e) {
                  // Handle deletion error (e.g., show a snackbar)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error deleting your data: $e'),
                    ),
                  );
                }
              }
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
              Navigator.pushReplacementNamed(context, RouteNameStrings.logIn);
            },
          ),
        ],
      ),
    );
  }
}
