import 'package:flutter/material.dart';

import '../models/assistant.dart';

class ListAssistant extends ChangeNotifier {
  late final List<ServiceProvider> _listAssistants;

  ListAssistant() {
    // Lazy initialization of the list
    _listAssistants = List<ServiceProvider>.unmodifiable([
      ServiceProvider(
        id: '1',
        username: 'provider1',
        password: 'password1',
        email: 'provider1@example.com',
        firstName: 'Naeim',
        lastName: 'Kudl',
        city: 'Ain beida',
        country: 'Algeria',
        postalCode: 16000,
        address: '1 Rue de la Liberté',
        specialitiesList: ['Child Care', 'Elderly Care'],
        joinDate: '1996-03-17',
        servicePrice: '50',
        qualificationsList: ['CPR Certification', 'First Aid Certification'],
        isValidated: true,
        phoneNumber: 1234567890,
        imageUrl: 'https://randomuser.me/api/portraits/med/men/1.jpg',
      ),
      ServiceProvider(
        id: '2',
        username: 'provider2',
        password: 'password2',
        email: 'provider2@example.com',
        firstName: 'Fatima',
        lastName: 'Zohra',
        city: 'Oran',
        country: 'Algeria',
        postalCode: 31000,
        address: '2 Boulevard de la Révolution',
        specialitiesList: ['House Care', 'Pet Care'],
        joinDate: '2022-04-01',
        servicePrice: '40',
        qualificationsList: ['Housekeeping Certification'],
        isValidated: true,
        phoneNumber: 2345678901,
        imageUrl: 'https://randomuser.me/api/portraits/med/men/2.jpg',
      ),
      ServiceProvider(
        id: '3',
        username: 'provider3',
        password: 'password3',
        email: 'provider3@example.com',
        firstName: 'Mohamed',
        lastName: 'Abdelaziz',
        city: 'Constantine',
        country: 'Algeria',
        postalCode: 25000,
        address: '3 Avenue du 1er Novembre',
        specialitiesList: ['Senior Care'],
        joinDate: '2022-04-01',
        servicePrice: '60',
        qualificationsList: ['Elderly Care Certification'],
        isValidated: true,
        phoneNumber: 3456789012,
        imageUrl: 'https://randomuser.me/api/portraits/med/men/3.jpg',
      ),
      ServiceProvider(
        id: '4',
        username: 'provider4',
        password: 'password4',
        email: 'provider4@example.com',
        firstName: 'Nadia',
        lastName: 'Toufik',
        city: 'Annaba',
        country: 'Algeria',
        postalCode: 23000,
        address: '4 Rue de l\'Indépendance',
        specialitiesList: ['Medical Care'],
        joinDate: '2022-04-01',
        servicePrice: '70',
        qualificationsList: ['Medical Degree'],
        isValidated: true,
        phoneNumber: 4567890123,
        imageUrl: 'https://randomuser.me/api/portraits/med/men/4.jpg',
      ),
      ServiceProvider(
        id: '5',
        username: 'provider5',
        password: 'password5',
        email: 'provider5@example.com',
        firstName: 'Lila',
        lastName: 'Youssef',
        city: 'Batna',
        country: 'Algeria',
        postalCode: 50000,
        address: '5 Boulevard du 1er Novembre',
        specialitiesList: ['House Care', 'Child Care'],
        joinDate: '2022-04-01',
        servicePrice: '45',
        qualificationsList: ['Child Development Certification'],
        isValidated: false,
        phoneNumber: 5678901234,
        imageUrl: 'https://randomuser.me/api/portraits/med/men/5.jpg',
      ),
    ]);
  }

  List<ServiceProvider> get listAssistants => _listAssistants;
  ServiceProvider? _currentAssistant;

  void setCurrentAssistant(ServiceProvider assistant) {
    _currentAssistant = assistant;
    notifyListeners();
  }

  ServiceProvider? get currentAssistant => _currentAssistant;
}
