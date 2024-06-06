import 'package:assistantsapp/models/address.dart';
import 'package:assistantsapp/services/string_to_date.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'enum/gender.dart';
import 'enum/role_enum.dart';

// Assuming you have an enum for Gender

class Client {
  final String id;
  final String email;
  final String userName;
  final Role role;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final Gender? gender;
  final List<DocumentReference>? appointments;
  final Address? address;
  final DateTime? birthday;
  final DateTime? joinDate;
  final bool? isValidated;
  final String? imageUrl;

  const Client({
    required this.id,
    required this.email,
    required this.userName,
    required this.role,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.address,
    this.appointments,
    this.birthday,
    this.joinDate,
    this.isValidated = false,
    this.imageUrl =
        "gs://appstartup-383e8.appspot.com/user_profile_images/avatar-place.png",
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw const FormatException('Client data is null or empty');
    }

    DateTime? parseDate(dynamic value) {
      if (value is String) return stringToDate(value);
      if (value is Timestamp) return value.toDate();
      return null;
    }

    List<DocumentReference> parseDocumentReferences(List<dynamic>? list) {
      return list?.map((e) => e as DocumentReference).toList() ?? [];
    }

    return Client(
      id: json['id'] ?? "",
      email: json['email'] ?? "",
      userName: json['userName'] ?? "",
      phoneNumber: json['phoneNumber'],
      role: Role.values.byName(json['role'] ?? ""),
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender:
          json['gender'] != null ? Gender.values.byName(json['gender']) : null,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      appointments: parseDocumentReferences(json['appointments']),
      birthday: parseDate(json['birthday']),
      joinDate: parseDate(json['joinDate']),
      isValidated: json['isValidated'],
      imageUrl: json['imageUrl'] ??
          "gs://appstartup-383e8.appspot.com/user_profile_images/avatar-place.png",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'role': role.name,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender?.name,
        'address': address?.toJson(),
        'birthday': birthday?.toIso8601String(),
        'joinDate': joinDate != null ? Timestamp.fromDate(joinDate!) : null,
        'isValidated': isValidated,
        'appointments': appointments,
        'imageUrl': imageUrl,
      };
}
