import 'package:assistantsapp/models/enum/role_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/string_to_date.dart';
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
  final Gender? gender;
  final DateTime birthday;
  final String? profileBio;
  final Address? address;
  final String? phoneNumber;
  final List<DocumentReference>? appointments;
  final ServiceType serviceType;
  final DateTime? joinDate;
  final String? servicePrice;
  final List<String>? skillsList;
  final bool? isValidated;
  final bool? associatedToEnterprise;
  final String? imageUrl;

  const Assistant({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.gender,
    required this.birthday,
    this.profileBio,
    this.address,
    this.phoneNumber,
    this.appointments,
    required this.serviceType,
    this.joinDate,
    this.servicePrice,
    this.skillsList,
    this.isValidated = false,
    this.associatedToEnterprise = false,
    this.imageUrl = "https://randomuser.me/api/portraits/med/women/17.jpg",
  });

  factory Assistant.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw const FormatException('Assistant data is null or empty');
    }

    DateTime? parseDate(dynamic value) {
      if (value is String) return stringToDate(value);
      if (value is Timestamp) return value.toDate();
      return null;
    }

    List<DocumentReference> parseDocumentReferences(List<dynamic>? list) {
      return list?.map((e) => e as DocumentReference).toList() ?? [];
    }

    return Assistant(
      id: json['id'] ?? "",
      userName: json['userName'] ?? "",
      email: json['email'] ?? "",
      role: Role.values.byName(json['role'] ?? ""),
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      gender:
          json['gender'] != null ? Gender.values.byName(json['gender']) : null,
      birthday: parseDate(json['birthday'])!,
      profileBio: json['profileBio'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      phoneNumber: json['phoneNumber'],
      appointments: parseDocumentReferences(json['appointments']),
      serviceType: ServiceType.values.byName(json['serviceType'] ?? ""),
      joinDate: parseDate(json['joinDate']),
      servicePrice: json['servicePrice'],
      skillsList: json['skillsList']?.cast<String>(),
      isValidated: json['isValidated'] ?? false,
      associatedToEnterprise: json['associatedToEnterprise'] ?? false,
      imageUrl: json['imageUrl'] ??
          "https://randomuser.me/api/portraits/med/women/17.jpg",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'email': email,
        'role': role.name,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender?.name,
        'birthday': birthday.toIso8601String(),
        'profileBio': profileBio,
        'address': address?.toJson(),
        'phoneNumber': phoneNumber,
        'appointments': appointments,
        'serviceType': serviceType.name,
        'joinDate': joinDate != null ? Timestamp.fromDate(joinDate!) : null,
        'servicePrice': servicePrice,
        'skillsList': skillsList,
        'isValidated': isValidated,
        'associatedToEnterprise': associatedToEnterprise,
        'imageUrl': imageUrl,
      };
}
