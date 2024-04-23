import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:assistantsapp/views/sharedwidgets/headline_with_row.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadlineRow(
              headline: "Account",
              subtitle: "keep your information update",
            ),
            SizedBox(height: 10),
            ListTile(
              title: const Text('personal data'),
              leading: const Icon(Icons.person),
              onTap: () {
                // Navigate to edit profile screen
              },
            ),
            ListTile(
              title: Text('Edit Password'),
              leading: Icon(Icons.password),
              onTap: () {
                // Navigate to edit profile screen
              },
            ),
            ListTile(
              title: const Text('im a assistant'),
              leading: const Icon(Icons.assistant),
              onTap: () {
                // Navigate to edit profile screen
              },
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
              title: Text('terme of use'),
              leading: Icon(Icons.data_usage),
              onTap: () {
                // Navigate to edit profile screen
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
      ),
    );
  }
}
