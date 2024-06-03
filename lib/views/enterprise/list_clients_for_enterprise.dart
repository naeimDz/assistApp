/*import 'package:assistantsapp/controllers/user_controller.dart';
import 'package:assistantsapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sharedwidgets/dialog_alert.dart';

class ListOfClients extends StatelessWidget {
  final String enterpriseId;
  const ListOfClients({super.key, required this.enterpriseId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
      stream: UserController().streamAllClients(enterpriseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final users = snapshot.data;
        if (users == null || users.isEmpty) {
          return const Text('No service providers available.');
        }

        return Wrap(
          children: users.map((User user) {
            return Column(
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Provider.of<UserController>(context, listen: false)
                        .userCurrent = user;
                    Provider.of<UserController>(context, listen: false)
                        .setusersCurrent(users);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogMakeAttendingListAssistants();
                      },
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.firstName?[0] ?? ""),
                    ),
                    subtitle: Text("${user.province}${user.city}"),
                    title: Text("${user.firstName}${user.lastName}"),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
*/