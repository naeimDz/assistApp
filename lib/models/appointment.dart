class Appointment {
  final String appointmentId;
  final String clientid;
  final String providerid;
  final DateTime dateTime;
  final String status;

  Appointment({
    required this.appointmentId,
    required this.clientid,
    required this.providerid,
    required this.dateTime,
    required this.status,
  });
}
