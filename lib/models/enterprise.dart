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
      throw FormatException('Enterprise data is null or empty');
    }
    return Enterprise(
      id: json['id'] as String,
      enterpriseName: json['enterpriseName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'],
      address: Address.fromJson(json['address']),
      birthday: stringToDate(json['birthday']),
      joinDate: json['joinDate'].toDate(),
      appointments: json['appointments'],
      subscriptions: json['subscriptions'],
      assistants: json['assistants'],
      clients: json['clients'],
      firstNameOwner: json['firstNameOwner'],
      lastNameOwner: json['lastNameOwner'],
      role: Role.values.byName(json['role']), // Handle invalid roles
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
        'address': address,
        'birthday': birthday,
        'joinDate': joinDate != null ? Timestamp.fromDate(joinDate!) : null,
        'appointments': appointments,
        'subscriptions': subscriptions,
        'assistants': assistants,
        'clients': clients,
        'firstNameOwner': firstNameOwner,
        'lastNameOwner': lastNameOwner,
        'role': role.name, // Use role.name for consistency
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
      };
}
