import 'package:assistantsapp/models/enum/appointment_status.dart';
import 'package:assistantsapp/services/firestore_service.dart';
import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:assistantsapp/views/appointment/widgets/appointment_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/appointment_controller.dart';
import '../../controllers/enterprise/enterprise_provider.dart';
import '../../models/appointment.dart';
import 'widgets/appointment_card.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  AppointmentScreenState createState() => AppointmentScreenState();
}

class AppointmentScreenState extends State<AppointmentScreen> {
  late AppointmentController _appointmentController;
  AppointmentStatus _selectedStatus = AppointmentStatus.pending;
  late String role;
  late String id;

  @override
  void initState() {
    super.initState();
    _appointmentController = AppointmentController();
    role = SharedPreferencesManager.getUserRole();
    id = FirestoreService().auth.currentUser!.uid;
  }

  void _onStatusChanged(AppointmentStatus? status) {
    if (status != null) {
      setState(() {
        _selectedStatus = status;
      });
    }
  }

  Widget _buildStatusFilter() {
    return DropdownButton<AppointmentStatus>(
      value: _selectedStatus,
      hint: const Text('Select status'),
      onChanged: _onStatusChanged,
      items: AppointmentStatus.values.map((status) {
        return DropdownMenuItem<AppointmentStatus>(
          value: status,
          child: Text(status.toString().split('.').last),
        );
      }).toList(),
    );
  }

  Widget _buildAppointmentsList(List<Appointment?>? appointments) {
    if (appointments == null || appointments.isEmpty) {
      return const Center(child: Text('No appointments found'));
    }
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return AppointmentCard(appointment: appointments[index]!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [_buildStatusFilter()],
      ),
      body: role != 'enterprises'
          ? StreamBuilder<List<Appointment?>>(
              stream: _appointmentController.getAppointmentsStreamByField(role,
                  fieldId: id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                List<Appointment?>? filteredAppointments =
                    filterAppointments(snapshot.data, _selectedStatus.name);
                return _buildAppointmentsList(filteredAppointments);
              },
            )
          : FutureBuilder<List<DocumentSnapshot>>(
              future: Provider.of<EnterpriseProvider>(context, listen: false)
                  .fetchAppointments(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No appointments found'));
                }
                List<Appointment?> appointments = snapshot.data!
                    .map((doc) => Appointment.fromJson(
                        doc.data() as Map<String, dynamic>, doc.id))
                    .toList();
                List<Appointment?>? filteredAppointments =
                    filterAppointments(appointments, _selectedStatus.name);
                return _buildAppointmentsList(filteredAppointments);
              },
            ),
    );
  }
}
