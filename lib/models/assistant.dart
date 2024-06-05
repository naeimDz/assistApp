import 'package:assistantsapp/models/enum/role_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'address.dart';
import 'enum/gender.dart';
import 'enum/service_type.dart';

class Assistant {
  final String id;
  final String userName;
  final String email;
  final Role role;

  final String firstName;
  final String lastName;
  final Gender gender;
  final DateTime birthday;
  final String? profileBio;
  final Address? address;

  final String? phoneNumber;
  final List<DocumentReference>? appointments;
  final ServiceType serviceType;
  final DateTime? joinDate;
  final String? servicePrice;
  final List<String>? skillsList;
  final bool isValidated;
  final bool associatedToEnterprise;

  final String? imageUrl;

  const Assistant({
    required this.id,
    required this.userName,
    required this.email,
    this.profileBio,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.gender = Gender.man,
    required this.birthday,
    this.address,
    this.phoneNumber,
    this.appointments,
    this.serviceType = ServiceType.childCare,
    this.joinDate,
    this.servicePrice,
    this.skillsList,
    this.isValidated = false,
    this.associatedToEnterprise = false,
    this.imageUrl =
        "gs://appstartup-383e8.appspot.com/user_profile_images/avatar-place.png",
  });

  factory Assistant.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw FormatException('Assistant data is null or empty');
    }

    return Assistant(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      role: Role.values.byName(json['role']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: Gender.values.byName(json['gender']),
      birthday: json['birthday'].toDate(),
      address: Address.fromJson(json['address']),
      appointments: (json['appointments']),
      phoneNumber: json['phoneNumber'],
      profileBio: json['profileBio'],
      serviceType: ServiceType.values.byName(json['serviceType']),
      joinDate: json['joinDate'].toDate(),
      servicePrice: json['servicePrice'],
      skillsList: (json['skillsList'] as List<dynamic>).cast<String>(),
      isValidated: json['isValidated'] as bool,
      associatedToEnterprise: json['associatedToEnterprise'] as bool,
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'email': email,
        'role': role.name,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender.name,
        'birthday': Timestamp.fromDate(
            birthday), // Use toIso8601String for serialization
        'address': address?.toJson(),
        'profileBio': profileBio,
        'phoneNumber': phoneNumber,
        'serviceType': serviceType.name,
        'appointments': appointments ?? [],
        'joinDate': joinDate != null ? Timestamp.fromDate(joinDate!) : null,
        'servicePrice': servicePrice,
        'skillsList': skillsList,
        'isValidated': isValidated,
        'associatedToEnterprise': associatedToEnterprise,
        'imageUrl': imageUrl,
      };
}
