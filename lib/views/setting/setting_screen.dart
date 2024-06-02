import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/sharedwidgets/headline_with_row.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    radius: 70,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          print("Edit Picture"), // Implement image picking
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
          SizedBox(height: 10),
          ListTile(
            title: const Text('personal data'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pushNamed(context, RouteNameStrings.editProfileView);
            },
          ),
          ListTile(
            title: Text('Edit Password'),
            leading: Icon(Icons.password),
            onTap: () {},
          ),
          ListTile(
            //trailing: Icon(Icons.arrow_forward),
            title: const Text('im a assistant'),
            leading: const Icon(Icons.assistant),
            onTap: () {},
          ),
          Divider(),
          const HeadlineRow(
            headline: "Application settings",
            subtitle: "Notification Settings",
          ),
          SizedBox(height: 10),
          SwitchListTile(
            title: Text('Push Notifications'),
            value: true, // Replace with actual value
            onChanged: (value) {
              // Update push notification setting
            },
          ),
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: false, // Replace with actual value
              onChanged: (value) {
                // Toggle dark mode
              },
            ),
          ),
          Divider(),
          const HeadlineRow(
            headline: "Privacy",
            subtitle: "protect your account",
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('delete your data'),
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
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              // Perform logout action
            },
          ),
        ],
      ),
    );
  }
}
