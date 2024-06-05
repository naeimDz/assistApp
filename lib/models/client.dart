import 'package:assistantsapp/models/address.dart';
import 'package:assistantsapp/services/string_to_date.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'enum/role_enum.dart';

class Client {
  final String id;
  final String email;
  final String userName;
  final Role role;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? gender;
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
      throw FormatException('Client data is null or empty');
    }

    return Client(
      id: json['id'] as String,
      email: json['email'] as String,
      userName: json["userName"],
      phoneNumber: json["phoneNumber"],
      role: Role.values.byName(json['role'] as String),
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      address: Address.fromJson(json['address']),
      appointments: json['appointments'],
      birthday: stringToDate(json['birthday']),
      joinDate: json['joinDate']?.toDate(),
      isValidated: json['isValidated'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'userName': userName,
        'phoneNumber': phoneNumber ?? "",
        'role': role.name,
        'firstName': firstName ?? "",
        'lastName': lastName ?? "",
        'gender': gender ?? "",
        'address': address?.toJson() ?? Address().toJson(),
        'birthday': joinDate != null ? Timestamp.fromDate(birthday!) : null,
        'joinDate': joinDate != null ? Timestamp.fromDate(joinDate!) : null,
        'isValidated': isValidated ?? false,
        'appointments': appointments ?? [],
        'imageUrl': imageUrl,
      };
}
