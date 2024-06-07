import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetermineUser {
// Inside your login function
  Future<String> determineUserRole(String field,
      {String? email, String? id}) async {
    String role = 'clients'; // Default role

    // Query the 'user' collection
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('clients')
        .where(field, isEqualTo: email ?? id)
        .get();
    if (userQuery.docs.isNotEmpty) {
      role = userQuery.docs.first.get('role');
      SharedPreferencesManager.setUserRole(role);
    }

    // Query the 'assist' collection
    QuerySnapshot assistQuery = await FirebaseFirestore.instance
        .collection('assistants')
        .where(field, isEqualTo: email ?? id)
        .get();
    if (assistQuery.docs.isNotEmpty) {
      role = assistQuery.docs.first.get('role');
      SharedPreferencesManager.setUserRole(role);
    }

    // Query the 'entreprise' collection
    QuerySnapshot entrepriseQuery = await FirebaseFirestore.instance
        .collection('enterprises')
        .where(field, isEqualTo: email ?? id)
        .get();
    if (entrepriseQuery.docs.isNotEmpty) {
      role = entrepriseQuery.docs.first.get('role');
      SharedPreferencesManager.setUserRole(role);
    }

    return role;
  }
}
