import 'package:assistantsapp/controllers/assistant/assistant_provider.dart';
import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/sharedwidgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/enterprise/enterprise_provider.dart';
import '../../services/firestore_service.dart';

class AssistantDetailScreen extends StatelessWidget {
  const AssistantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final assistant = Provider.of<AssistantProvider>(context).selectedAssistant;
    return Scaffold(
      appBar: AppBar(
        title: Text(assistant?.username ?? ""),
      ),
      body: SingleChildScrollView(
        // Wrap body with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: circleAvatar(assistant?.imageUrl, assistant?.firstName,
                  radius: 80),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${assistant?.firstName} ${assistant?.lastName} ',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "${assistant?.serviceType.name} (${assistant?.servicePrice ?? 'N/A'} DA)",
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Skills :',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: assistant?.skillsList
                      ?.map((skill) => Chip(label: Text(skill)))
                      .toList() ??
                  [const Text("No Skiils")],
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Information:',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(assistant?.phoneNumber ?? 'N/A'),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(assistant?.email ?? ""),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(assistant?.address.toString() ?? ""),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  var role = SharedPreferencesManager.getUserRole();
                  if (role != 'enterprise') {
                    var enterpriseId = FirestoreService().auth.currentUser!.uid;

                    EnterpriseProvider()
                        .addToEnterprise(enterpriseId, assistant!.id, true);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Subscribe sent successfully! '),
                      backgroundColor: Colors.green,
                    ));
                  } else {
                    Navigator.pushNamed(
                        context, RouteNameStrings.appointScreen);
                  }
                },
                child: Text("lets connect"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
