import 'package:assistantsapp/models/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'enum/gender.dart';
import 'enum/role_enum.dart';

class Client {
  final String id;
  final String email;
  final String username;
  final String phoneNumber;
  final Role role;
  final String firstName;
  final String lastName;
  final Gender gender;
  final List<DocumentReference> appointments;
  final Address address;
  final DateTime birthday;
  final DateTime joinDate;
  final bool isValidated;
  final String imageUrl;

  const Client({
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.appointments,
    required this.birthday,
    required this.joinDate,
    required this.isValidated,
    required this.imageUrl,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw FormatException('Client data is null or empty');
    }

    return Client(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json["username"] ?? "",
      phoneNumber: json["phoneNumber"],
      role: Role.values.byName(json['role'] as String),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: Gender.values.byName(json['gender'] as String),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      appointments:
          (json['appointments'] as List<dynamic>).cast<DocumentReference>(),
      birthday: (json['birthday'] as Timestamp).toDate(),
      joinDate: (json['joinDate'] as Timestamp).toDate(),
      isValidated: json['isValidated'] as bool,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
        'phoneNumber': phoneNumber,
        'role': role.name,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender.name,
        'address': address.toJson(),
        'birthday': Timestamp.fromDate(birthday),
        'joinDate': Timestamp.fromDate(joinDate),
        'isValidated': isValidated,
        'appointments': appointments,
        'imageUrl': imageUrl,
      };
}
