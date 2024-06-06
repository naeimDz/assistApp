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
    this.isRecurring = false,
    this.cancellationReason = "",
    this.recurrencePattern = RecurrencePattern.none,
    this.status = AppointmentStatus.pending,
    this.allDay = false,
    this.enterpriseCreator,
  });

  factory Appointment.fromJson(Map<String, dynamic> json, String id) {
    DateTime? stringToDate(String? dateString) {
      if (dateString == null || dateString.isEmpty) {
        return null;
      }
      try {
        return DateTime.parse(dateString);
      } catch (e) {
        print('Error parsing date: $e');
        return null;
      }
    }

    try {
      return Appointment(
        appointmentID: id,
        assistantDisplayName: json['assistantDisplayName'] as String? ?? "",
        recurrencePattern: RecurrencePattern.values.firstWhere(
            (element) => element.name == (json['recurrencePattern'] ?? ""),
            orElse: () => RecurrencePattern.none),
        assistantEmail: json['assistantEmail'] as String? ?? "",
        cancellationReason: json['cancellationReason'] as String? ?? "",
        status: AppointmentStatus.values.firstWhere(
            (e) => e.name == (json['status'] ?? ""),
            orElse: () => AppointmentStatus.pending),
        clientEmail: json['clientEmail'] as String? ?? "",
        clientDisplayName: json['clientDisplayName'] as String? ?? "",
        clientId: json['clientId'] as String? ?? "",
        creationDate: stringToDate(json['creationDate']),
        duration: Duration(seconds: json['duration'] as int? ?? 0),
        dateTime: stringToDate(json['dateTime']),
        isRecurring: json['isRecurring'] as bool? ?? false,
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        providerId: json['providerId'] as String? ?? "",
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
        'creationDate': creationDate?.toIso8601String(),
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
