import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/conversations.dart';
import '../../services/firestore_service.dart';

class ConversationController {
  final FirestoreService _firestoreService = FirestoreService();
  final String collectionName = 'conversations';

  Future<DocumentReference?> createOrCheckConversation(
      Conversation conversation, String id, String Assistid) async {
    try {
      // Query Firestore for existing conversations
      final querySnapshot = await _firestoreService.firestore
          .collection(collectionName)
          .where('assistantId', isEqualTo: Assistid)
          .where('userId', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Conversation exists - handle appropriately
        final existingConversation = querySnapshot.docs.first;
        print('Conversation already exists: ${existingConversation.id}');

        // Option 1: Update existing conversation (if applicable)
        await _firestoreService.updateDocument(
            collectionName, existingConversation.id, conversation.toJson());

        // Option 2: Return existing conversation reference (for fetching messages)
        return existingConversation.reference;
      } else {
        // No conversation exists - create a new one
        final docRef = await _firestoreService.firestore
            .collection(collectionName)
            .add(conversation.toJson());
        return docRef;
      }
    } catch (e) {
      print('Error creating or checking conversation: $e');
      return null; // Indicate error by returning null
    }
  }

  Future<Conversation?> getConversationById(String conversationId) async {
    try {
      final snapshot = await _firestoreService.getDocumentById(
          collectionName, conversationId);
      if (snapshot != null && snapshot.exists) {
        Conversation conversation = Conversation.fromJson(snapshot.data()!);

        return conversation;
      }
    } catch (e) {
      print('Error getting conversation by ID: $e');
    }
    return null;
  }

  Future<List<Conversation>> getAllConversations() async {
    try {
      final snapshot = await _firestoreService.getAllDocuments(collectionName);
      if (snapshot != null) {
        List<Conversation> conversations = [];
        for (var doc in snapshot.docs) {
          Conversation conversation = Conversation.fromJson(doc.data());

          conversations.add(conversation);
        }
        return conversations;
      }
    } catch (e) {
      print('Error getting all conversations: $e');
    }
    return [];
  }

  Future<void> deleteConversation(String conversationId) async {
    try {
      await _firestoreService.deleteDocument(collectionName, conversationId);
    } catch (e) {
      print('Error deleting conversation: $e');
    }
  }

  Stream<List<Conversation>> getConversationsStream(String role) async* {
    final uid = FirestoreService().auth.currentUser?.uid;
    var query1 = _firestoreService.firestore
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .snapshots();
    var query2 = _firestoreService.firestore
        .collection(collectionName)
        .where('assistantId', isEqualTo: uid)
        .snapshots();

    await for (var snapshot1 in query1) {
      var snapshot2 = await query2.first;

      yield [...snapshot1.docs, ...snapshot2.docs]
          .map((doc) => Conversation.fromJson(doc.data(), id: doc.id))
          .toList();
    }
  }
}
