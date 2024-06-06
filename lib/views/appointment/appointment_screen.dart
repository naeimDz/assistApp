import 'package:assistantsapp/models/enum/appointment_status.dart';
import 'package:assistantsapp/services/firestore_service.dart';
import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../controllers/appointment_controller.dart';
import '../../controllers/enterprise/enterprise_provider.dart';
import '../../models/appointment.dart';
import 'widgets/appointment_card.dart';
import 'widgets/appointment_filter.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  AppointmentScreenState createState() => AppointmentScreenState();
}

class AppointmentScreenState extends State<AppointmentScreen> {
  late AppointmentController _appointmentController;
  AppointmentStatus _selectedStatus = AppointmentStatus.pending;
  var role = SharedPreferencesManager.getUserRole();
  var id = FirestoreService().auth.currentUser!.uid;
  @override
  void initState() {
    _appointmentController = AppointmentController();
    super.initState();
  }

  Widget _buildStatusFilter() {
    return DropdownButton<AppointmentStatus>(
      value: _selectedStatus,
      hint: Text('Select status'),
      onChanged: (status) {
        setState(() {
          _selectedStatus = status!;
        });
      },
      items: AppointmentStatus.values.map((status) {
        return DropdownMenuItem<AppointmentStatus>(
          value: status,
          child: Text(status.toString().split('.').last),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [_buildStatusFilter()],
      ),
      body: SharedPreferencesManager.getUserRole() != 'enterprises'
          ? StreamBuilder<List<Appointment?>>(
              stream: _appointmentController.getAppointmentsStreamByField(role,
                  fieldId: id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No appointments found'));
                } else {
                  List<Appointment?>? appointments =
                      filterAppointments(snapshot.data, _selectedStatus.name);

                  return ListView.builder(
                    itemCount: appointments!.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(appointment: appointments[index]!);
                    },
                  );
                }
              },
            )
          : FutureBuilder<List<DocumentSnapshot>>(
              future: EnterpriseProvider().fetchAppointments(id),
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
                  //      final List<Appointment?>? filteredAppointments =filterAppointments(data, _selectedStatus.name);

                  return Wrap(
                    children: data.map((DocumentSnapshot doc) {
                      var appointment = Appointment.fromJson(
                          doc.data() as Map<String, dynamic>, doc.id);

                      // Filter based on assistant.status (assuming assistant.status is a property)
                      if (appointment.status.name == _selectedStatus.name) {
                        return AppointmentCard(
                            appointment:
                                appointment); // Replace with your desired widget
                      } else {
                        return const SizedBox.shrink();
                      }
                    }).toList(),
                  );
                }
              },
            ),
    );
  }
}
/*


          FutureBuilder<List<DocumentSnapshot>>(
              future: enterpriseProvider.fetchClients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                var clients = snapshot.data;
                if (clients == null || clients.isEmpty) {
                  return const Text('No Clients available.');
                }
                return Wrap(
                  children: clients.map((DocumentSnapshot doc) {
                    var client =
                        Client.fromJson(doc.data() as Map<String, dynamic>);
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            /* Provider.of<UserController>(context, listen: false)
                        .userCurrent = user;
                    Provider.of<UserController>(context, listen: false)
                        .setusersCurrent(users);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogMakeAttendingListAssistants();
                      },
                    );*/
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(client.firstName[0]),
                            ),
                            subtitle: Text(
                                "${client.address.province}${client.address.city}"),
                            title:
                                Text("${client.firstName}${client.lastName}"),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),
*/