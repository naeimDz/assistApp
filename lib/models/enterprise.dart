import 'package:cloud_firestore/cloud_firestore.dart';
import 'address.dart';
import 'enum/role_enum.dart';

class Enterprise {
  final String enterpriseID;
  final String enterpriseName;
  final String email;
  final String? phoneNumber;
  final Address? address;
  final DateTime?
      birthday; // Consider using a specific type for birthday (e.g., DateTime)

  // Use explicit types and avoid dynamic for clarity and safety
  final List<DocumentReference>? appointments;
  final List<DocumentReference>? subscriptions; // Required, hence non-nullable
  final List<DocumentReference>? assistants;
  final List<DocumentReference>? clients;

  final String? firstNameOwner;
  final String? lastNameOwner;
  final Role role;
  final String? price;
  final String? description;
  final String? logoUrl;

  const Enterprise({
    required this.enterpriseID,
    required this.enterpriseName,
    required this.email,
    this.phoneNumber,
    this.address,
    this.birthday,
    this.appointments,
    this.subscriptions,
    this.assistants,
    this.clients,
    this.firstNameOwner,
    this.lastNameOwner,
    required this.role,
    this.price,
    this.description,
    this.logoUrl,
  });

  factory Enterprise.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw FormatException('Enterprise data is null or empty');
    }
    return Enterprise(
      enterpriseID: json['enterpriseID'] as String,
      enterpriseName: json['enterpriseName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>?),
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'] as String)
          : null,
      appointments:
          (json['appointments'] as List<dynamic>?)?.cast<DocumentReference>(),
      subscriptions:
          (json['subscriptions'] as List<dynamic>?)?.cast<DocumentReference>(),
      assistants:
          (json['assistants'] as List<dynamic>?)?.cast<DocumentReference>(),
      clients: (json['clients'] as List<dynamic>?)?.cast<DocumentReference>(),
      firstNameOwner: json['firstNameOwner'] as String?,
      lastNameOwner: json['lastNameOwner'] as String?,
      role: Role.values.byName(json['role'] as String), // Handle invalid roles
      price: json['price'] as String?,
      description: json['description'] as String?,
      logoUrl: json['logoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'enterpriseID': enterpriseID,
        'enterpriseName': enterpriseName,
        'email': email,
        'phoneNumber': phoneNumber ?? "",
        'address': address?.toJson() ?? Address().toJson(),
        'birthday': birthday?.toIso8601String(),
        'appointments': appointments ?? [],
        'subscriptions': subscriptions ?? [],
        'assistants': assistants ?? [],
        'clients': clients ?? [],
        'firstNameOwner': firstNameOwner ?? "",
        'lastNameOwner': lastNameOwner ?? "",
        'role': role.name, // Use role.name for consistency
        'price': price ?? "",
        'description': description ?? "",
        'logoUrl': logoUrl ?? "",
      };
}
