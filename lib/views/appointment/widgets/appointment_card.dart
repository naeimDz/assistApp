import 'package:assistantsapp/models/appointment.dart';

import 'package:flutter/material.dart';

import '../../../controllers/appointment_controller.dart';
import '../../../models/enum/appointment_status.dart';
import '../../../models/enum/role_enum.dart';
import '../../../services/date_utils.dart';
import '../../../services/shared_preferences_manager.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 45,
                child: Center(
                  child: Text(
                    "${appointment.duration?.inHours.toString() ?? '0'} H",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              title:
                  Text(appointment.assistantDisplayName ?? 'Unknown Assistant'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "scheduled with ${appointment.clientDisplayName ?? 'Unknown Client'}"),
                  Text(
                    appointment.enterpriseCreator != null
                        ? "${appointment.enterpriseCreator}"
                        : "",
                    style: const TextStyle(color: Colors.purple),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: getStatusColor(appointment.status.name),
                          shape: BoxShape.circle),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      appointment.status.name,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  appointment.dateTime != null
                      ? Utils.fullDayFormat(appointment.dateTime!)
                      : 'No Date',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${appointment.price?.round() ?? 0} DZD",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        showCancellationDialog(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.cancel, color: Colors.red),
                          SizedBox(width: 5),
                          Text('Cancel', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    TextButton(
                      onPressed: () {
                        showReschedulingDialog(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.update, color: Colors.blue),
                          SizedBox(width: 5),
                          Text('Update Status',
                              style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "confirmed":
        return Colors.green;
      case "cancelledByClient":
      case "cancelledByProvider":
        return Colors.black;
      case "completed":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void showCancellationDialog(BuildContext context) {
    final TextEditingController _noteController =
        TextEditingController(text: "Reason for cancellation ");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cancel Appointment"),
          content: TextField(
            controller: _noteController,
            maxLines: 17,
            minLines: 3,
            decoration:
                const InputDecoration(hintText: "Reason for cancellation"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var role = SharedPreferencesManager.getUserRole();
                var noteCancellation = _noteController.text;
                Map<String, dynamic> data = {
                  'cancellationReason': noteCancellation
                };

                if (role == Role.clients.name) {
                  data['status'] = AppointmentStatus.cancelledByClient.name;
                } else {
                  data['status'] = AppointmentStatus.cancelledByProvider.name;
                }

                AppointmentController()
                    .updateAppointment(appointment.appointmentID!, data);

                Navigator.of(context).pop();
              },
              child: const Text('Cancel with Note'),
            ),
          ],
        );
      },
    );
  }

  void showReschedulingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reschedule Appointment'),
          content: const Text('Select a new status for the appointment.'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform rescheduling logic here

                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
