import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/string_to_date.dart';
import 'address.dart';
import 'enum/role_enum.dart';

class Enterprise {
  final String id;
  final String enterpriseName;
  final String email;
  final String? phoneNumber;
  final Address? address;
  final DateTime? birthday;
  final DateTime? joinDate;
  final List<DocumentReference>? appointments;
  final List<DocumentReference>? subscriptions;
  final List<DocumentReference>? assistants;
  final List<DocumentReference>? clients;
  final String? firstNameOwner;
  final String? lastNameOwner;
  final Role role;
  final String? price;
  final String? description;
  final String? imageUrl;

  const Enterprise({
    required this.id,
    required this.enterpriseName,
    required this.email,
    this.phoneNumber,
    this.address,
    this.birthday,
    this.joinDate,
    this.appointments,
    this.subscriptions,
    this.assistants,
    this.clients,
    this.firstNameOwner,
    this.lastNameOwner,
    required this.role,
    this.price,
    this.description,
    this.imageUrl,
  });

  factory Enterprise.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw const FormatException('Enterprise data is null or empty');
    }

    DateTime? parseDate(dynamic value) {
      if (value is String) return stringToDate(value);
      if (value is Timestamp) return value.toDate();
      return null;
    }

    List<DocumentReference> parseDocumentReferences(List<dynamic>? list) {
      return list?.map((e) => e as DocumentReference).toList() ?? [];
    }

    return Enterprise(
      id: json['id'] ?? "",
      enterpriseName: json['enterpriseName'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phoneNumber'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      birthday: parseDate(json['birthday']),
      joinDate: parseDate(json['joinDate']),
      appointments: parseDocumentReferences(json['appointments']),
      subscriptions: parseDocumentReferences(json['subscriptions']),
      assistants: parseDocumentReferences(json['assistants']),
      clients: parseDocumentReferences(json['clients']),
      firstNameOwner: json['firstNameOwner'],
      lastNameOwner: json['lastNameOwner'],
      role: Role.values.byName(json['role']),
      price: json['price'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'enterpriseName': enterpriseName,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address?.toJson(),
        'birthday': birthday != null ? Timestamp.fromDate(birthday!) : null,
        'joinDate': joinDate != null ? Timestamp.fromDate(joinDate!) : null,
        'appointments': appointments,
        'subscriptions': subscriptions,
        'assistants': assistants,
        'clients': clients,
        'firstNameOwner': firstNameOwner,
        'lastNameOwner': lastNameOwner,
        'role': role.name,
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
      };
}
