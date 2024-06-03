import 'package:assistantsapp/models/appointment.dart';
import 'package:flutter/material.dart';
import '../../../models/enum/appointment_status.dart';
import '../../../services/date_utils.dart';

class AppointmentCard extends StatefulWidget {
  final Appointment appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  late AppointmentStatus _status;

  @override
  void initState() {
    super.initState();
    _status = widget.appointment.status;
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
                      widget.appointment.assistantDisplayName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "scheduled with ${widget.appointment.clientDisplayName}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                        Text(
                          widget.appointment.enterpriseCreator ?? "",
                          style: const TextStyle(color: Colors.purple),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "${widget.appointment.price.round()}DZD",
                      style: const TextStyle(color: Colors.black54),
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
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            Utils.apiDayFormat(widget.appointment.dateTime),
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_filled,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.appointment.duration.inHours.toString()} hours",
                            style: const TextStyle(color: Colors.black54),
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
                            _status.name,
                            style: const TextStyle(color: Colors.black54),
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
      case AppointmentStatus.pending:
      case AppointmentStatus.confirmed:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildActionButton(
              buttonText: 'Reschedule',
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
      case AppointmentStatus.cancelledByClient:
      case AppointmentStatus.cancelledByProvider:
      case AppointmentStatus.completed:
      case AppointmentStatus.noShow:
        // case AppointmentStatus.rescheduled:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
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
                // Perform cancellation logic here
                setState(() {
                  _status = AppointmentStatus.cancelledByClient;
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
          title: const Text('Reschedule Appointment'),
          content:
              const Text('Select a new date and time for the appointment.'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform rescheduling logic here
                setState(() {
                  _status = AppointmentStatus.confirmed;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Reschedule'),
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

  Color getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Colors.orange;
      case AppointmentStatus.confirmed:
        return Colors.green;
      case AppointmentStatus.cancelledByClient:
      case AppointmentStatus.cancelledByProvider:
        return Colors.black;
      case AppointmentStatus.completed:
        return Colors.blue;
      /*case AppointmentStatus.rescheduled:
        return Colors.purple;*/
      case AppointmentStatus.noShow:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
