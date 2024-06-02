/*import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import '../../controllers/appointment_controller_provider.dart';
import '../../models/appointment.dart';
import '../../services/database.dart';
import 'widgets/appointment_card.dart';
import 'widgets/appointment_filter.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  AppointmentScreenState createState() => AppointmentScreenState();
}

class AppointmentScreenState extends State<AppointmentScreen> {
  late AppointmentController _appointmentController;
  AppointmentStatus _selectedStatus = AppointmentStatus.scheduled;

  @override
  void initState() {
    _appointmentController = AppointmentController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          DropdownButton<AppointmentStatus>(
            value: _selectedStatus,
            items: AppointmentStatus.values.map((status) {
              return DropdownMenuItem<AppointmentStatus>(
                value: status,
                child: Text(status.name.toUpperCase()),
              );
            }).toList(),
            onChanged: (newStatus) =>
                setState(() => _selectedStatus = newStatus!),
          ),
        ],
      ),
      body: SharedPreferencesManager.getUserRole() != 'Enterprise'
          ? StreamBuilder<List<Appointment>>(
              stream: _appointmentController.getAppointmentsByRole(
                  id: Database.auth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No appointments found'));
                } else {
                  final List<Appointment> filteredAppointments =
                      filterAppointments(snapshot.data!, _selectedStatus.name);

                  return ListView.builder(
                    itemCount: filteredAppointments.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                          appointment: filteredAppointments[index]);
                    },
                  );
                }
              },
            )
          : FutureBuilder<List<Appointment>>(
              future: _appointmentController
                  .getAppointmentsForEnterprise(Database.auth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No appointments found'));
                } else {
                  final List<Appointment> filteredAppointments =
                      filterAppointments(snapshot.data!, _selectedStatus.name);

                  return ListView.builder(
                    itemCount: filteredAppointments.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                          appointment: filteredAppointments[index]);
                    },
                  );
                }
              },
            ),
    );
  }
}
*/