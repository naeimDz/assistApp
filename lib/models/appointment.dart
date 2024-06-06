import '../services/string_to_date.dart';
import 'enum/appointment_status.dart';
import 'enum/recurrence_pattern.dart';

class Appointment {
  final String? appointmentID;
  final String assistantDisplayName;
  final String assistantEmail;
  final String? cancellationReason;
  final String clientEmail;
  final String clientDisplayName;
  final String clientId;
  final DateTime? dateTime;
  final DateTime? creationDate;
  final Duration? duration;
  final Duration? durationReply;
  final bool? isRecurring;
  final double? price;
  final String? providerId;
  final RecurrencePattern? recurrencePattern;
  final AppointmentStatus status;
  final bool? allDay;
  final String? enterpriseCreator;

  const Appointment({
    this.appointmentID,
    required this.assistantDisplayName,
    required this.assistantEmail,
    required this.providerId,
    required this.clientEmail,
    required this.clientDisplayName,
    required this.clientId,
    required this.dateTime,
    required this.duration,
    required this.price,
    required this.creationDate,
    this.durationReply,
    this.isRecurring,
    this.cancellationReason,
    this.recurrencePattern,
    required this.status,
    this.allDay,
    this.enterpriseCreator,
  });

  factory Appointment.fromJson(Map<String, dynamic> json, String id) {
    try {
      return Appointment(
        appointmentID: id,
        assistantDisplayName: json['assistantDisplayName'] as String,
        assistantEmail: json['assistantEmail'] as String,
        cancellationReason: json['cancellationReason'] as String,
        clientEmail: json['clientEmail'] as String,
        clientDisplayName: json['clientDisplayName'] as String,
        clientId: json['clientId'] as String,
        dateTime: stringToDate(json['birthday']),
        creationDate: stringToDate(json['birthday']),
        duration: Duration(seconds: json['duration'] as int),
        durationReply: json['durationReply'] != null
            ? Duration(seconds: json['durationReply'] as int)
            : null,
        isRecurring: json['isRecurring'] as bool,
        price: json['price'] as double,
        providerId: json['providerId'] as String,
        recurrencePattern: RecurrencePattern.values
            .firstWhere((element) => element.name == json['recurrencePattern']),
        status: AppointmentStatus.values
            .firstWhere((e) => e.toString() == json['status']),
        allDay: json['allDay'] as bool,
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
        'assistantDisplayName': assistantDisplayName,
        'assistantEmail': assistantEmail,
        'cancellationReason': cancellationReason,
        'clientEmail': clientEmail,
        'clientDisplayName': clientDisplayName,
        'clientId': clientId,
        'dateTime': dateTime?.toIso8601String(),
        'duration': duration?.inHours,
        'durationReply': durationReply?.inMinutes,
        'isRecurring': isRecurring,
        'price': price,
        'providerId': providerId,
        'recurrencePattern': recurrencePattern?.name,
        'status': status.name,
        'allDay': allDay,
        'enterpriseCreator': enterpriseCreator
      };
}
