import 'package:assistantsapp/models/enum/role_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/appointment.dart';
import '../services/firestore_service.dart';

class AppointmentController {
  final FirestoreService _firestoreService = FirestoreService();
  final String collectionName = 'appointments';

  Future<void> createAppointment(Appointment appointment) async {
    await _firestoreService.firestore
        .collection(collectionName)
        .doc()
        .set(appointment.toJson());
  }

  DocumentReference<Map<String, dynamic>> createAppointmen(
      {Appointment? appointment}) {
    final docRef = _firestoreService.firestore.collection(collectionName).doc();

    docRef.set(appointment!.toJson());
    return docRef;
  }

  Future<Appointment?> getAppointmentById(String appointmentId) async {
    final snapshot =
        await _firestoreService.getDocumentById(collectionName, appointmentId);
    if (snapshot != null && snapshot.exists) {
      return Appointment.fromJson(snapshot.data()!, appointmentId);
    }
    return null;
  }

  Future<void> updateAppointment(
      String appointmentId, Map<String, dynamic> data) async {
    await _firestoreService.updateDocument(collectionName, appointmentId, data);
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _firestoreService.deleteDocument(collectionName, appointmentId);
  }

  Stream<List<Appointment?>> getAppointmentsStreamByField(String role,
      {String? fieldId}) {
    var query = _firestoreService.query(collectionName);

    // Filter by role (optional)
    if (role == Role.clients.name) {
      query = query.where('clientId', isEqualTo: fieldId);
    } else if (role == Role.assistants.name) {
      query = query.where('providerId', isEqualTo: fieldId);
    }
    query = query.orderBy('dateTime', descending: false);
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              return Appointment.fromJson(
                  doc.data() as Map<String, dynamic>, doc.id);
            } catch (e) {
              print('Error parsing appointment: $e');
              return null;
            }
          })
          .where((appointment) => appointment != null)
          .toList();
    }).handleError((error) {
      print('Error fetching appointments: $error');
      return [];
    });
  }
}
