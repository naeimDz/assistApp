import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/conversations.dart';
import '../models/message.dart';
import '../services/firestore_service.dart';

class ConversationController {
  final FirestoreService _firestoreService;
  final String collectionName = 'conversations';
  ConversationController(this._firestoreService);

  Future<void> createOrCheckConversation(Conversation conversation) async {
    try {
      // Query Firestore to check if a conversation already exists between the same sender and receiver
      QuerySnapshot<Map<String, dynamic>> existingConversations =
          await _firestoreService.firestore
              .collection(collectionName)
              .where('assistantId', isEqualTo: conversation.assistantId)
              .where('userId', isEqualTo: conversation.userId)
              .get();

      if (existingConversations.docs.isNotEmpty) {
        // If a conversation exists, handle it appropriately (e.g., update or notify user)
        print('Conversation already exists between the assistant and user.');
        // You can update the existing conversation here if needed
        updateConversation(existingConversations.docs.first.id, conversation);
      } else {
        // If no conversation exists, create a new one
        DocumentReference docRef = await _firestoreService.firestore
            .collection(collectionName)
            .add(conversation.toJson());

        // Add messages to the new conversation document
        for (var message in conversation.messages) {
          await docRef.collection('messages').add(message.toJson());
        }
      }
    } catch (e) {
      print('Error creating or checking conversation: $e');
    }
  }

  Future<Conversation?> getConversationById(String conversationId) async {
    try {
      final snapshot = await _firestoreService.getDocumentById(
          collectionName, conversationId);
      if (snapshot != null && snapshot.exists) {
        Conversation conversation = Conversation.fromJson(snapshot.data()!);

        // Fetch messages for the conversation
        QuerySnapshot<Map<String, dynamic>> messagesSnapshot =
            await snapshot.reference.collection('messages').get();
        List<Message> messages = messagesSnapshot.docs
            .map((doc) => Message.fromJson(doc.data()))
            .toList();
        conversation = Conversation(
          assistantDisplayName: conversation.assistantDisplayName,
          assistantId: conversation.assistantId,
          lastMessage: conversation.lastMessage,
          userDisplayName: conversation.userDisplayName,
          userId: conversation.userId,
          messages: messages,
        );

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

          // Fetch messages for the conversation
          QuerySnapshot<Map<String, dynamic>> messagesSnapshot =
              await doc.reference.collection('messages').get();
          List<Message> messages = messagesSnapshot.docs
              .map((messageDoc) => Message.fromJson(messageDoc.data()))
              .toList();
          conversation = Conversation(
            assistantDisplayName: conversation.assistantDisplayName,
            assistantId: conversation.assistantId,
            lastMessage: conversation.lastMessage,
            userDisplayName: conversation.userDisplayName,
            userId: conversation.userId,
            messages: messages,
          );

          conversations.add(conversation);
        }
        return conversations;
      }
    } catch (e) {
      print('Error getting all conversations: $e');
    }
    return [];
  }

  Future<void> updateConversation(
      String conversationId, Conversation conversation) async {
    try {
      await _firestoreService.updateDocument(
          collectionName, conversationId, conversation.toJson());

      // Update messages in the conversation document
      for (var message in conversation.messages) {
        await _firestoreService.firestore
            .collection(collectionName)
            .doc(conversationId)
            .collection('messages')
            .add(message.toJson());
      }
    } catch (e) {
      print('Error updating conversation: $e');
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    try {
      await _firestoreService.deleteDocument(collectionName, conversationId);
    } catch (e) {
      print('Error deleting conversation: $e');
    }
  }

  Stream<List<Conversation>> getConversationsStream() {
    return _firestoreService.firestore
        .collection(collectionName)
        .snapshots()
        .asyncMap((snapshot) async {
      List<Conversation> conversations = [];
      for (var doc in snapshot.docs) {
        Conversation conversation = Conversation.fromJson(doc.data());

        // Fetch messages for the conversation
        QuerySnapshot<Map<String, dynamic>> messagesSnapshot =
            await doc.reference.collection('messages').get();
        List<Message> messages = messagesSnapshot.docs
            .map((messageDoc) => Message.fromJson(messageDoc.data()))
            .toList();
        conversation = Conversation(
          assistantDisplayName: conversation.assistantDisplayName,
          assistantId: conversation.assistantId,
          lastMessage: conversation.lastMessage,
          userDisplayName: conversation.userDisplayName,
          userId: conversation.userId,
          messages: messages,
        );

        conversations.add(conversation);
      }
      return conversations;
    }).handleError((error) {
      print('Error getting conversations stream: $error');
    });
  }
}
