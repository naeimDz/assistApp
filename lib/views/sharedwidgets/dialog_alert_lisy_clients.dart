/*import 'package:assistantsapp/controllers/user_controller.dart';
import 'package:assistantsapp/models/user.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
    List<User> data =
        Provider.of<UserController>(context, listen: false).usersCurrent;

    return AlertDialog(
      title: Text('pick one'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300, // Adjust the height as needed
        child: ListView.builder(
          itemCount: data.length, // Replace userList with your list of users
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                  "${data[index].firstName} ${data[index].lastName}"), // Replace with user data
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
              Provider.of<UserController>(context, listen: false).userCurrent =
                  data[selectedIndex];

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AppointScreen(),
              ));
            }
          },
          child: const Text('make appointement'),
        ),
      ],
    );
  }
}
*/