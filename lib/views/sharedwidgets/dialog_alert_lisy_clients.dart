import 'package:assistantsapp/controllers/client/client_provider.dart';
import 'package:assistantsapp/models/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controllers/enterprise/enterprise_provider.dart';
import '../appointment/appoint_screen.dart';

class DialogMakeAttendingClients extends StatefulWidget {
  const DialogMakeAttendingClients({super.key});

  @override
  State<DialogMakeAttendingClients> createState() =>
      _DialogMakeAttendingClientsState();
}

class _DialogMakeAttendingClientsState
    extends State<DialogMakeAttendingClients> {
  int selectedIndex = -1; // Initially no item is selected

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: EnterpriseProvider().fetchClients(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        var data = snapshot.data;
        if (data == null || data.isEmpty) {
          return const Center(child: Text('No appointments found'));
        } else {
          return Wrap(
            children: data.map((DocumentSnapshot doc) {
              var client = Client.fromJson(doc.data() as Map<String, dynamic>);

              return AlertDialog(
                title: Text('pick one'),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 300, // Adjust the height as needed
                  child: ListView.builder(
                    itemCount:
                        data.length, // Replace userList with your list of users
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            "${client.firstName} ${client.lastName}"), // Replace with user data
                        tileColor: selectedIndex == index
                            ? Colors.green.withOpacity(0.3)
                            : null, // Change color if selected
                        onTap: () {
                          setState(() {
                            selectedIndex = index; // Update selected index
                          });
                          // Handle attend appointment action for the selected user
                        },
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (selectedIndex != -1) {
                        Provider.of<ClientProvider>(context, listen: false)
                            .selectClient(client.id);

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AppointScreen(),
                        ));
                      }
                    },
                    child: const Text('make appointement'),
                  ),
                ],
              );
            }).toList(),
          );
        }
      },
    );
  }
}
