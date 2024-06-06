import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/assistant/assistant_provider.dart';
import '../../controllers/conversations/conversation_controller.dart';
import '../../controllers/conversations/message_controller.dart';
import '../../models/conversations.dart';
import '../../models/message.dart';
import '../../services/firestore_service.dart';

Future<DocumentReference<Object?>> makeConversation(
    BuildContext context, String text,
    {String? enterpriseid, String? enterpriseName}) async {
  try {
    var assistant = Provider.of<AssistantProvider>(context, listen: false)
        .selectedAssistant;
    var currentUser = FirestoreService().auth.currentUser;
    final textDescription = text == ""
        ? "I hope this message finds you well. I am writing to request an appointment with you "
        : text;

    var newConversation = Conversation(
        assistantDisplayName: enterpriseName ?? assistant!.userName,
        assistantId: enterpriseid ?? assistant!.id,
        lastMessage: textDescription,
        userDisplayName: currentUser!.displayName ?? "missesName",
        userId: currentUser.uid);

    var ref = await ConversationController().createOrCheckConversation(
        newConversation, currentUser.uid, enterpriseid ?? assistant!.id);
    MessageController().addMessage(
        ref!.id,
        Message(
            senderUid: currentUser.uid,
            content: textDescription,
            timestamp: Timestamp.now()));

    return ref;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}
