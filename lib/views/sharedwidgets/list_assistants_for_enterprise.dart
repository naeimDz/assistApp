/*import 'package:assistantsapp/views/sharedwidgets/dialog_alert_lisy_clients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/assistant_controller_provider.dart';
import '../../models/assistant.dart';

class ListOfAssist extends StatelessWidget {
  final String enterpriseId;

  const ListOfAssist({super.key, required this.enterpriseId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Assistant>>(
      future: Provider.of<AssistantControllerProvider>(context, listen: false)
          .getAssistantsForEnterprise(enterpriseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No assistants found.'));
        } else {
          List<Assistant> assistants = snapshot.data!;

          return Wrap(
            children: assistants.map((Assistant assistant) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AssistantControllerProvider>(context,
                              listen: false)
                          .assistant = assistant;
                      Provider.of<AssistantControllerProvider>(context,
                              listen: false)
                          .setAssistants(assistants);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogMakeAttendingClients();
                        },
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(assistant.username?[0] ?? ""),
                      ),
                      subtitle: Text("${assistant.province}${assistant.city}"),
                      title: Text(
                          "${assistant.firstName ?? assistant.username}${assistant.lastName}"),
                    ),
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
*/