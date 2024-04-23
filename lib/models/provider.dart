import 'package:cloud_firestore/cloud_firestore.dart';

class Provider {
  String id;
  String username;
  String password;
  String email;
  String firstName;
  String lastName;
  //String latitude;
  //String longitude;
  String city;
  String country;
  int postalCode;
  String address;
  List<String> specialitiesList;
  String joinDate;
  String servicePrice;
  List<String> qualificationsList;
  bool isValidated;
  int phoneNumber;
  String imageUrl;

  Provider({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    this.firstName = "",
    this.lastName = "",
    // this.latitude = "",
    //this.longitude = "",
    this.city = "",
    this.country = "",
    this.postalCode = 0,
    this.address = "",
    this.specialitiesList = const [],
    this.joinDate = "",
    this.servicePrice = "",
    this.qualificationsList = const [],
    this.isValidated = false,
    this.phoneNumber = 213,
    this.imageUrl = "",
  });

  factory Provider.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);

    return Provider(
      id: doc.id,
      username: data['username'],
      password: data['password'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      //latitude: data['latitude'],
      //longitude: data['longitude'],
      city: data['city'],
      country: data['country'],
      postalCode: data['postalCode'],
      address: data['address'],
      specialitiesList: List<String>.from(data['specialitiesList']),
      joinDate: data['joinDate'],
      servicePrice: data['servicePrice'],
      qualificationsList: List<String>.from(data['qualificationsList']),
      isValidated: data['isValidated'],
      phoneNumber: data['phoneNumber'],
      imageUrl: data['imageUrl'],
    );
  }

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      //latitude: json['latitude'],
      //longitude: json['longitude'],
      city: json['city'],
      country: json['country'],
      postalCode: json['postalCode'],
      address: json['address'],
      specialitiesList: json['specialitiesList'] != null
          ? List<String>.from(json['specialitiesList'])
          : [],
      joinDate: json['joinDate'],
      servicePrice: json['servicePrice'],
      qualificationsList: json['qualificationsList'] != null
          ? List<String>.from(json['qualificationsList'])
          : [],
      isValidated: json['isValidated'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      //'latitude': latitude,
      //'longitude': longitude,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'address': address,
      'specialitiesList': specialitiesList,
      'joinDate': joinDate,
      'servicePrice': servicePrice,
      'qualificationsList': qualificationsList,
      'isValidated': isValidated,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }
}
