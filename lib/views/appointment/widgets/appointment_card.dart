import 'package:flutter/material.dart';
import '../../../controllers/appointment_controller.dart';
import '../../../models/appointment.dart';
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
                    "${appointment.duration.inHours.toString()} H",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              title: Text(
                appointment.assistantDisplayName,
                style: const TextStyle(color: Colors.black87),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Scheduled with ${appointment.clientDisplayName}",
                    style: const TextStyle(color: Colors.black38),
                  ),
                  if (appointment.enterpriseCreator != null)
                    Text(
                      "by: ${appointment.enterpriseCreator} #Enterprise",
                      style: const TextStyle(color: Colors.purple),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: getStatusColor(appointment.status.name),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      appointment.status.name,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Utils.fullDayFormat(appointment.dateTime),
                      style: const TextStyle(color: Colors.black54),
                    ),
                    Text(
                      Utils.timeFormat(appointment.dateTime),
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (appointment.status != AppointmentStatus.cancelledByClient &&
                appointment.status != AppointmentStatus.cancelledByProvider)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${appointment.price.round()} DZD",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      if (appointment.status == AppointmentStatus.pending)
                        TextButton(
                          onPressed: () {
                            showCancellationDialog(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.cancel, color: Colors.red),
                              SizedBox(width: 5),
                              Text('Cancel',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      const VerticalDivider(),
                      if (appointment.status != AppointmentStatus.completed)
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
    final TextEditingController noteController =
        TextEditingController(text: "Reason for cancellation ");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cancel Appointment"),
          content: TextField(
            controller: noteController,
            maxLines: 5,
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
                var noteCancellation = noteController.text;
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
    List<AppointmentStatus> statusList = [
      AppointmentStatus.confirmed,
      AppointmentStatus.pending,
      AppointmentStatus.completed
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Appointment Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select a new status for the appointment:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              DropdownButton<AppointmentStatus>(
                value: appointment.status,
                onChanged: (AppointmentStatus? newStatus) {
                  if (newStatus != null) {
                    AppointmentController().updateAppointment(
                        appointment.appointmentID!, {'status': newStatus.name});
                    Navigator.of(context).pop();
                  }
                },
                items: statusList.map((AppointmentStatus status) {
                  return DropdownMenuItem<AppointmentStatus>(
                    value: status,
                    child: Text(status.name),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
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
