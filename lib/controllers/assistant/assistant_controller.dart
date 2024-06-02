import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/assistant.dart';
import '../../services/firestore_service.dart';

class AssistantController {
  final FirestoreService _firestoreService = FirestoreService();
  final String collectionName = 'assistants'; //providers

  // Fetch all assistants
  Future<List<Assistant>> getAssistants() async {
    QuerySnapshot<Map<String, dynamic>>? snapshot =
        await _firestoreService.getAllDocuments(collectionName);
    if (snapshot != null) {
      return snapshot.docs
          .map((doc) => Assistant.fromJson(doc.data()))
          .toList();
    }
    return [];
  }

  // Fetch a single assistant by ID
  Future<Assistant?> getAssistantById(String id) async {
    DocumentSnapshot<Map<String, dynamic>>? doc =
        await _firestoreService.getDocumentById(collectionName, id);
    if (doc != null && doc.exists) {
      return Assistant.fromJson(doc.data()!);
    }
    return null;
  }

  // Add a new assistant
  Future<void> addAssistant(Assistant assistant) async {
    await _firestoreService.createDocument(
        collectionName, assistant.id, assistant.toJson());
  }

  // Update an existing assistant
  Future<void> updateAssistant(Assistant assistant) async {
    await _firestoreService.updateDocument(
        collectionName, assistant.id, assistant.toJson());
  }

  // Delete an assistant
  Future<void> deleteAssistant(String id) async {
    await _firestoreService.deleteDocument(collectionName, id);
  }
}
