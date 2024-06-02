import 'package:assistantsapp/models/enum/role_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'address.dart';
import 'enum/gender.dart';
import 'enum/service_type.dart';

class Assistant {
  final String id;
  final String username;
  final String email;
  final Role role;

  final String firstName;
  final String lastName;
  final Gender gender;
  // final Timestamp birthday;
  final String? profileBio;
  final Address? address;

  final String? phoneNumber;
  final List<DocumentReference>? appointments;
  final ServiceType serviceType;
  final Timestamp? joinDate;
  final String? servicePrice;
  final List<String>? skillsList;
  final bool isValidated;
  final bool associatedToEnterprise;

  final String? imageUrl;

  const Assistant({
    required this.id,
    required this.username,
    required this.email,
    this.profileBio,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.gender = Gender.man,
//    required this.birthday,
    this.address,
    this.phoneNumber,
    this.appointments,
    this.serviceType = ServiceType.childCare,
    this.joinDate,
    this.servicePrice,
    this.skillsList,
    this.isValidated = false,
    this.associatedToEnterprise = false,
    this.imageUrl,
  });

  factory Assistant.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw FormatException('Assistant data is null or empty');
    }

    return Assistant(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: Role.values.byName(json['role']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: Gender.values.byName(json['gender']),
      // birthday: Timestamp.fromDate(json['birthday']),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      appointments: (json['appointments']),
      phoneNumber: json['phoneNumber'],
      profileBio: json['profileBio'],
      serviceType: ServiceType.values.byName(json['serviceType']),
      //   joinDate: Timestamp.fromDate(json['joinDate']),
      servicePrice: json['servicePrice'],
      skillsList: (json['skillsList'] as List<dynamic>).cast<String>(),
      isValidated: json['isValidated'] as bool,
      associatedToEnterprise: json['associatedToEnterprise'] as bool,
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'role': role.name,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender.name,
        //   'birthday': birthday.toDate(), // Use toIso8601String for serialization
        'address': address?.toJson(),
        'profileBio': profileBio,
        'phoneNumber': phoneNumber,
        'serviceType': serviceType.name,
        'appointments': appointments,
        //  'joinDate': joinDate?.toDate(),
        'servicePrice': servicePrice,
        'skillsList': skillsList,
        'isValidated': isValidated,
        'associatedToEnterprise': associatedToEnterprise,
        'imageUrl': imageUrl,
      };
}
