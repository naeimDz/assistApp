import '../models/appointment.dart';
import '../services/firestore_service.dart';

class AppointmentController {
  final FirestoreService _firestoreService;
  final String collectionName = 'appointments';
  AppointmentController(this._firestoreService);

  Future<void> createAppointment(Appointment appointment) async {
    await _firestoreService.firestore
        .collection(collectionName)
        .doc()
        .set(appointment.toJson());
  }

  Future<Appointment?> getAppointmentById(String appointmentId) async {
    final snapshot =
        await _firestoreService.getDocumentById(collectionName, appointmentId);
    if (snapshot != null && snapshot.exists) {
      return Appointment.fromJson(snapshot.data()!);
    }
    return null;
  }

  Future<List<Appointment>> getAllAppointments() async {
    final snapshot = await _firestoreService.getAllDocuments(collectionName);
    if (snapshot != null) {
      return snapshot.docs
          .map((doc) => Appointment.fromJson(doc.data()))
          .toList();
    }
    return [];
  }

  Future<void> updateAppointment(
      String appointmentId, Appointment appointment) async {
    await _firestoreService.updateDocument(
        collectionName, appointmentId, appointment.toJson());
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _firestoreService.deleteDocument(collectionName, appointmentId);
  }

  Stream<List<Appointment>> getAppointmentsStream() {
    return _firestoreService.firestore
        .collection(collectionName)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Appointment.fromJson(doc.data()))
          .toList();
    });
  }
}
