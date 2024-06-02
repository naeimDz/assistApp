import 'package:cloud_firestore/cloud_firestore.dart';

class DetermineUser {
// Inside your login function
  Future<String> determineUserRole(String email) async {
    String role = 'user'; // Default role

    // Query the 'user' collection
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userQuery.docs.isNotEmpty) {
      role = userQuery.docs.first.get('role');
    }

    // Query the 'assist' collection
    QuerySnapshot assistQuery = await FirebaseFirestore.instance
        .collection('providers')
        .where('email', isEqualTo: email)
        .get();
    if (assistQuery.docs.isNotEmpty) {
      role = assistQuery.docs.first.get('role');
    }

    // Query the 'entreprise' collection
    QuerySnapshot entrepriseQuery = await FirebaseFirestore.instance
        .collection('enterprises')
        .where('email', isEqualTo: email)
        .get();
    if (entrepriseQuery.docs.isNotEmpty) {
      role = entrepriseQuery.docs.first.get('role');
    }

    return role;
  }
}
