import '../../models/message.dart';
import '../../services/firestore_service.dart';

class MessageController {
  final FirestoreService _firestoreService;
  final String collectionName = 'conversations';

  MessageController(this._firestoreService);

  Future<void> addMessage(String conversationId, Message message) async {
    try {
      // Add the message to the 'messages' subcollection of the conversation
      await _firestoreService.firestore
          .collection(collectionName)
          .doc(conversationId)
          .collection('messages')
          .add(message.toJson());

      // Update the lastMessage and lastMessageTimestamp fields in the conversation document
      await _firestoreService.firestore
          .collection(collectionName)
          .doc(conversationId)
          .update({
        'lastMessage': message.content,
      });
    } catch (e) {
      print('Error adding message: $e');
    }
  }

  Future<List<Message>> getMessages(String conversationId) async {
    try {
      final snapshot = await _firestoreService.firestore
          .collection(collectionName)
          .doc(conversationId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }
}
