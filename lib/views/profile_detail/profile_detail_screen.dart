import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the selected assistant from the provider
    //final assistant = Provider.of<ListAssistant>(context).currentAssistant;
    return Scaffold(
      appBar: AppBar(
        title: Text('Assistant Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                // Placeholder image
              ),
            ),
            const SizedBox(height: 20),
            /* Text(
              "${assistant!.firstName} ${assistant!.lastName}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
             Text(
              assistant.specialitiesList[0],
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),*/
            const SizedBox(height: 20),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce suscipit massa id velit ultrices, vitae lacinia mauris volutpat.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            /* ListTile(
              leading: const Icon(Icons.phone),
              title: Text(assistant.phoneNumber.toString()),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(assistant.email),
            ),
           ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                  '${assistant?.address ?? ''}, ${assistant?.city ?? ''}, ${assistant?.country ?? ''}'),
            ),*/
          ],
        ),
      ),
    );
  }
}
