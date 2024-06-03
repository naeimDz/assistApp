import 'package:assistantsapp/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/enterprise.dart';

class EnterpriseController {
  final FirestoreService _db = FirestoreService();
  final String collectionName = 'enterprises';

  // Fetch all enterprises
  Future<List<Enterprise>> getEnterprises() async {
    QuerySnapshot? snapshot = await _db.getAllDocuments(collectionName);

    return snapshot!.docs.map((doc) {
      return Enterprise.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // Fetch a single enterprise by ID
  Future<Enterprise?> getEnterpriseById(String id) async {
    DocumentSnapshot? doc = await _db.getDocumentById(collectionName, id);
    if (doc!.exists) {
      return Enterprise.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Add a new enterprise
  Future<void> addEntrprise(Enterprise enterprise) async {
    await _db.createDocument(
        collectionName, enterprise.enterpriseID, enterprise.toJson());
  }

  // Update an existing enterprise
  Future<void> updateEnterprise(Enterprise enterprise) async {
    await _db.updateDocument(
        collectionName, enterprise.enterpriseID, enterprise.toJson());
  }

  // Delete a enterprise
  Future<void> deleteEnterprise(String id) async {
    await _db.deleteDocument(collectionName, id);
  }
/*
  Future<void> addToEnterprise(
      String enterpriseId, String id, String? isAssistant) async {
    DocumentReference enterpriseRef =await _db.getDocumentById(collectionName, enterpriseId);

    // Determine the correct collection reference
    DocumentReference userOrAssistantRef;
    if (isAssistant == "Assistant") {
      userOrAssistantRef = Database.dbInstance.collection('providers').doc(id);
    } else {
      userOrAssistantRef = Database.dbInstance.collection('users').doc(id);
    }

    await _db.firestore.runTransaction((transaction) async {
      DocumentSnapshot enterpriseSnapshot =
          await transaction.get(enterpriseRef);

      if (enterpriseSnapshot.exists) {
        // Retrieve the correct list based on whether it's an assistant or not
        List<dynamic> usersOrAssists = isAssistant == "Assistant"
            ? List.from(enterpriseSnapshot.get('assists') ?? [])
            : List.from(enterpriseSnapshot.get('users') ?? []);

        // Add the new reference
        usersOrAssists.add(userOrAssistantRef);

        // Remove duplicates by converting to a set and back to a list
        usersOrAssists = usersOrAssists.toSet().toList();

        // Update the Firestore document with the deduplicated list
        transaction.update(enterpriseRef, {
          isAssistant == "Assistant" ? 'assists' : 'clients': usersOrAssists
        });
      }
    });
  }*/
}
