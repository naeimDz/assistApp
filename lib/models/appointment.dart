import 'package:flutter/material.dart';

import 'enum/appointment_status.dart';
import 'enum/recurrence_pattern.dart';

class Appointment {
  final String? appointmentID;
  final String assistantDisplayName;
  final String assistantEmail;
  final String cancellationReason;
  final String clientEmail;
  final String clientDisplayName;
  final String clientId;
  final DateTime dateTime;
  final Duration duration;
  final Duration durationReply;
  final bool isRecurring;
  final double price; // Use double for price to accommodate decimals
  final String providerId;
  final RecurrencePattern recurrencePattern;
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
    this.durationReply = Durations.long1,
    this.isRecurring = false,
    this.cancellationReason = "",
    this.recurrencePattern = RecurrencePattern.none,
    this.status = AppointmentStatus.pending,
    this.allDay = false,
    this.enterpriseCreator,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    try {
      return Appointment(
          appointmentID: json['appointmentID'],
          assistantDisplayName: json['assistantDisplayName'] as String,
          assistantEmail: json['assistantEmail'] as String,
          cancellationReason: json['cancellationReason'] as String,
          clientEmail: json['clientEmail'] as String,
          clientDisplayName: json['clientdisplayName'] as String,
          clientId: json['clientid'] as String,
          dateTime: DateTime.parse(json['dateTime'] as String),
          duration: json['duration'] as Duration,
          durationReply: json['durationReply'] as Duration,
          isRecurring: json['isRecurring'] as bool,
          price: json['price'] as double, // Use double for price
          providerId: json['providerid'] as String,
          recurrencePattern: RecurrencePattern.values.firstWhere(
              (element) => element.name == json['recurrencePattern']),
          status: AppointmentStatus.values
              .firstWhere((e) => e.toString() == json['status']),
          enterpriseCreator: json['enterpriseCreator'],
          allDay: json['allDay'] as bool);
    } on FormatException catch (e) {
      // Handle format exceptions (e.g., invalid dateTime string)
      print("Error parsing appointment data: $e");
      throw Exception(
          "Invalid appointment data format"); // Re-throw a more generic exception
    } catch (e) {
      // Handle other unexpected errors
      print("Unexpected error parsing appointment data: $e");
      throw Exception(
          "Error creating Appointment"); // Re-throw a generic exception
    }
  }

  Map<String, dynamic> toJson() => {
        'appointmentID': appointmentID,
        'assistantDisplayName': assistantDisplayName,
        'assistantEmail': assistantEmail,
        'cancellationReason': cancellationReason,
        'clientEmail': clientEmail,
        'clientdisplayName': clientDisplayName,
        'clientid': clientId,
        'dateTime': dateTime
            .toIso8601String(), // Use toIso8601String for consistent formatting
        'duration': duration,
        'durationReply': durationReply,
        'isRecurring': isRecurring,
        'price': price,
        'providerid': providerId,
        'recurrencePattern': recurrencePattern,
        'status': status,
        'allDay': allDay,
        'enterpriseCreator': enterpriseCreator
      };
}
