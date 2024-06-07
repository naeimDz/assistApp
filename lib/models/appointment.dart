import '../services/string_to_date.dart';
import 'enum/appointment_status.dart';
import 'enum/recurrence_pattern.dart';

class Appointment {
  final String? appointmentID;
  final String assistantDisplayName;
  final String assistantId;
  final String assistantEmail;
  final String cancellationReason;
  final String clientEmail;
  final String clientDisplayName;
  final String clientId;
  final DateTime dateTime;
  final DateTime creationDate;
  final Duration duration;
  final Duration? durationReply;
  final bool isRecurring;
  final double price;

  final RecurrencePattern recurrencePattern;
  final AppointmentStatus status;
  final bool allDay;
  final String? enterpriseCreator;

  const Appointment({
    this.appointmentID,
    required this.assistantDisplayName,
    required this.assistantEmail,
    required this.assistantId,
    required this.clientEmail,
    required this.clientDisplayName,
    required this.clientId,
    required this.dateTime,
    required this.duration,
    required this.price,
    required this.creationDate,
    this.durationReply,
    this.isRecurring = false,
    this.cancellationReason = "",
    this.recurrencePattern = RecurrencePattern.none,
    this.status = AppointmentStatus.pending,
    this.allDay = false,
    this.enterpriseCreator,
  });

  factory Appointment.fromJson(Map<String, dynamic> json, String id) {
    try {
      return Appointment(
        appointmentID: id,
        assistantDisplayName: json['assistantDisplayName'] ?? "",
        assistantEmail: json['assistantEmail'] ?? "",
        cancellationReason: json['cancellationReason'] ?? "",
        status: AppointmentStatus.values.firstWhere(
            (e) => e.name == (json['status'] ?? ""),
            orElse: () => AppointmentStatus.pending),
        clientEmail: json['clientEmail'] ?? "",
        clientDisplayName: json['clientDisplayName'] ?? "",
        clientId: json['clientId'] ?? "",
        creationDate: stringToDate(json['creationDate']) ?? DateTime.now(),
        duration: Duration(hours: json['duration'] ?? 0),
        dateTime: stringToDate(json['dateTime']) ?? DateTime.now(),
        isRecurring: json['isRecurring'] ?? false,
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        assistantId: json['assistantId'] ?? "",
        recurrencePattern: RecurrencePattern.values.firstWhere(
            (e) => e.name == (json['recurrencePattern'] ?? ""),
            orElse: () => RecurrencePattern.none),
        allDay: json['allDay'] ?? false,
        enterpriseCreator: json['enterpriseCreator'],
      );
    } on FormatException catch (e) {
      print("Error parsing appointment data: $e");
      throw Exception("Invalid appointment data format");
    } catch (e) {
      print("Unexpected error parsing appointment data: $e");
      throw Exception("Error creating Appointment");
    }
  }

  Map<String, dynamic> toJson() => {
        'appointmentID': appointmentID,
        'assistantDisplayName': assistantDisplayName,
        'assistantEmail': assistantEmail,
        'cancellationReason': cancellationReason,
        'clientEmail': clientEmail,
        'clientDisplayName': clientDisplayName,
        'clientId': clientId,
        'dateTime': dateTime.toIso8601String(),
        'creationDate': creationDate.toIso8601String(),
        'duration': duration.inSeconds,
        'durationReply': durationReply?.inMinutes,
        'isRecurring': isRecurring,
        'price': price,
        'assistantId': assistantId,
        'recurrencePattern': recurrencePattern.name,
        'status': status.name,
        'allDay': allDay,
        'enterpriseCreator': enterpriseCreator,
      };
}
