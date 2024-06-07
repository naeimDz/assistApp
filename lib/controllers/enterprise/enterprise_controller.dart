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
        collectionName, enterprise.id, enterprise.toJson());
  }

  // Update an existing enterprise
  Future<void> updateEnterprise(Enterprise enterprise) async {
    await _db.updateDocument(
        collectionName, enterprise.id, enterprise.toJson());
  }

  // Delete a enterprise
  Future<void> deleteEnterprise(String id) async {
    await _db.deleteDocument(collectionName, id);
  }

  Future<List<DocumentSnapshot>> getDocuments(
      List<DocumentReference>? references) async {
    if (references == null || references.isEmpty) {
      return [];
    }
    List<DocumentSnapshot> documents = [];
    for (DocumentReference ref in references) {
      DocumentSnapshot doc = await ref.get();

      documents.add(doc);
    }

    return documents;
  }

  Future<void> addToEnterprise(
      String enterpriseId, String id, String fieldName) async {
    DocumentSnapshot enterpriseSnapshot = (await _db.getDocumentById(
        collectionName, enterpriseId)) as DocumentSnapshot<Object?>;
    DocumentReference enterpriseRef = enterpriseSnapshot.reference;
    // Determine the correct collection reference
    DocumentReference userOrAssistantRef;
    if (fieldName == "assistants") {
      userOrAssistantRef = _db.firestore.collection('assistants').doc(id);
    } else if (fieldName == "clients") {
      userOrAssistantRef = _db.firestore.collection('clients').doc(id);
    } else {
      userOrAssistantRef = _db.firestore.collection('appointments').doc(id);
    }

    await _db.firestore.runTransaction((transaction) async {
      DocumentSnapshot enterpriseSnapshot =
          await transaction.get(enterpriseRef);

      if (enterpriseSnapshot.exists) {
        // Retrieve the correct list based on whether it's an assistant or not
        List<dynamic> usersOrAssists;

        if (fieldName == "assistants") {
          usersOrAssists =
              List.from(enterpriseSnapshot.get('assistants') ?? []);
        } else if (fieldName == "clients") {
          usersOrAssists = List.from(enterpriseSnapshot.get('clients') ?? []);
        } else {
          usersOrAssists =
              List.from(enterpriseSnapshot.get('appointments') ?? []);
        }

        // Add the new reference
        usersOrAssists.add(userOrAssistantRef);

        // Remove duplicates by converting to a set and back to a list
        usersOrAssists = usersOrAssists.toSet().toList();

        // Update the Firestore document with the deduplicated list
        transaction.update(enterpriseRef, {fieldName: usersOrAssists});
      }
    });
  }
}
