import 'package:assistantsapp/models/assistant.dart';
import 'package:assistantsapp/models/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/appointment_controller.dart';
import '../../controllers/assistant/assistant_provider.dart';
import '../../controllers/client/client_provider.dart';
import '../../controllers/enterprise/enterprise_provider.dart';
import '../../models/appointment.dart';
import '../../models/enum/appointment_status.dart';
import '../../services/firestore_service.dart';
import '../../utils/routes/route_name_strings.dart';

class DialogMakeAttendingAssistants extends StatefulWidget {
  final DateTime selectedDate;
  final String priceController;
  final Duration durationHours;
  const DialogMakeAttendingAssistants(
      {super.key,
      required this.selectedDate,
      required this.priceController,
      required this.durationHours});

  @override
  State<DialogMakeAttendingAssistants> createState() =>
      _DialogMakeAttendingAssistantsState();
}

class _DialogMakeAttendingAssistantsState
    extends State<DialogMakeAttendingAssistants> {
  int selectedIndex = -1; // Initially no item is selected
  var enterpriseID = FirestoreService().auth.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    var clientSelected =
        Provider.of<ClientProvider>(context, listen: false).selectedClient;
    return FutureBuilder<List<DocumentSnapshot>>(
      future: EnterpriseProvider().fetchaAsists(enterpriseID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        var data = snapshot.data;
        if (data == null || data.isEmpty) {
          return AlertDialog(
              content: const Text('No assistants found'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
              ]);
        } else {
          List<ListTile> assistantsList = data.map((DocumentSnapshot doc) {
            var assistant = Client.fromJson(doc.data() as Map<String, dynamic>);
            int index = data.indexOf(doc);
            return ListTile(
              title: Text(
                  "${assistant.firstName} ${assistant.lastName}"), // Replace with user data
              tileColor: selectedIndex == index
                  ? Colors.green.withOpacity(0.3)
                  : null, // Change color if selected
              onTap: () {
                setState(() {
                  selectedIndex = index; // Update selected index
                  Provider.of<AssistantProvider>(context, listen: false)
                      .selectAssistant(assistant.id);
                });
                // Handle attend appointment action for the selected user
              },
            );
          }).toList();

          return AlertDialog(
            title: Text('pick one'),
            content: SizedBox(
              width: double.maxFinite,
              height: 300, // Adjust the height as needed
              child: ListView.builder(
                itemCount: assistantsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return assistantsList[index];
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Provider.of<AssistantProvider>(context, listen: false)
                      .nullAssistant(null);
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (selectedIndex != -1) {
                    var assistant = Assistant.fromJson(
                        data[selectedIndex].data() as Map<String, dynamic>);

                    var newAppointmentByEnterprise = Appointment(
                      creationDate: DateTime.now(),
                      assistantDisplayName: assistant.lastName,
                      assistantEmail: assistant.email,
                      assistantId: assistant.id,
                      clientEmail: clientSelected!.email,
                      clientDisplayName: clientSelected.userName,
                      dateTime: widget.selectedDate,
                      duration: widget.durationHours,
                      price: double.parse(widget.priceController),
                      clientId: clientSelected.id,
                      enterpriseCreator:
                          FirestoreService().auth.currentUser?.displayName ??
                              FirestoreService().auth.currentUser!.email,
                      status: AppointmentStatus.confirmed,
                    );

                    try {
                      var res = AppointmentController().createAppointme(
                          appointment: newAppointmentByEnterprise);
                      print(res);
                      EnterpriseProvider().addToEnterprise(
                          enterpriseID, res.id, "appointments");
                      Navigator.popAndPushNamed(
                        context,
                        RouteNameStrings.homeScreen,
                      );
                    } on Exception catch (e) {
                      // Handle exception here
                      print("Error creating appointment: $e");
                      // You can also show a user-friendly error message using a dialog or snackbar
                    }
                  }
                },
                child: const Text('chose Assistant'),
              ),
            ],
          );
        }
      },
    );
  }
}
