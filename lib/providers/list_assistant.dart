import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/assistant.dart';

class ListAssistant extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<ServiceProvider> _listAssistants = [];

  List<ServiceProvider> get listAssistants => _listAssistants;
  ServiceProvider? _currentAssistant;

  ListAssistant() {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final snapshot = await _db.collection('providers').get();
      _listAssistants = snapshot.docs
          .map((doc) => ServiceProvider.fromFirestore(doc))
          .toList();
      notifyListeners(); // Notify dependents of data update
    } catch (error) {
      // Handle potential errors during data fetching
      print("Error fetching data: $error");
    }
  }

  void setCurrentAssistant(ServiceProvider assistant) {
    _currentAssistant = assistant;
    notifyListeners();
  }

  ServiceProvider? get currentAssistant => _currentAssistant;
}
