/*import 'package:assistantsapp/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/appointment_controller_provider.dart';
import '../../../services/date_utils.dart';

class AppointmentCard extends StatefulWidget {
  final Appointment appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.appointment.status.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, spreadRadius: 2),
              ],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      widget.appointment.assistantDisplayName ??
                          widget.appointment.assistantEmail ??
                          "AssistantName",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        "scheduled with ${widget.appointment.clientdisplayName}"),
                    trailing: Text(
                      "${widget.appointment.price.round()}DZD",
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      thickness: 1,
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.appointment.appointmentCreation?.day != null
                                ? Utils.apiDayFormat(
                                    widget.appointment.dateTime)
                                : "",
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_filled,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.appointment.duration.inHours.toString()} hours",
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: getStatusColor(_status),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            _status,
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildActionButtons(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildActionButtons() {
    switch (_status) {
      case 'scheduled':
      case 'confirmed':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildActionButton(
              buttonText: 'Rescheduled',
              backgroundColor: const Color(0xFF7165D6),
              textColor: Colors.white,
              onPressed: () => showReschedulingDialog(),
            ),
            buildActionButton(
              buttonText: 'Cancel',
              backgroundColor: const Color(0xFFF4F6FA),
              textColor: Colors.black,
              onPressed: () => showCancellationDialog(),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget buildActionButton({
    required String buttonText,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 173,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  void showCancellationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cancel Appointment"),
          content: const TextField(
            maxLines: 17,
            minLines: 3,
            decoration: InputDecoration(hintText: "Reason for cancellation"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AppointmentController>(
                  context,
                  listen: false,
                ).updateAppointmentStatus(
                  widget.appointment.id!,
                  AppointmentStatus.cancelled.name,
                );
                setState(() {
                  _status = AppointmentStatus.cancelled.name;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Cancel with Note'),
            ),
          ],
        );
      },
    );
  }

  void showReschedulingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Status'),
          content: const Text('Select the new status for the appointment.'),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<AppointmentController>(
                  context,
                  listen: false,
                ).updateAppointmentStatus(
                  widget.appointment.id!,
                  AppointmentStatus.completed.name,
                );
                setState(() {
                  _status = AppointmentStatus.completed.name;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Complete'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AppointmentController>(
                  context,
                  listen: false,
                ).updateAppointmentStatus(
                  widget.appointment.id!,
                  AppointmentStatus.confirmed.name,
                );
                setState(() {
                  _status = AppointmentStatus.confirmed.name;
                });
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

  Color getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return Colors.orange;
      case 'cancelled':
        return Colors.black;
      case 'completed':
        return Colors.blue;
      case 'confirmed':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
*/