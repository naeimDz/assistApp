import 'package:flutter/material.dart';
import '../../controllers/conversations/conversation_controller.dart';
import '../../models/conversations.dart';
import '../../services/shared_preferences_manager.dart';
import 'message_screen.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversation"),
      ),
      body: StreamBuilder<List<Conversation>>(
        stream: ConversationController()
            .getConversationsStream(SharedPreferencesManager.getUserRole()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No conversations found.'));
          } else {
            List<Conversation> conversations = snapshot.data!;

            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                Conversation conversation = conversations[index];
                String lastMessagePreview = conversation.lastMessage.length > 40
                    ? '${conversation.lastMessage.substring(0, 40)}.....'
                    : conversation.lastMessage;
                return Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 3,
                      leading: CircleAvatar(
                        child: Text(
                            '${conversation.assistantDisplayName[0].toUpperCase()}${conversation.userDisplayName[0].toUpperCase()}'),
                      ),
                      title: Text(
                          "${conversation.assistantDisplayName} __ ${conversation.userDisplayName}"),
                      subtitle: Text(lastMessagePreview),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageScreen(
                                conversationId: conversation.id!,
                                displayName: conversation.assistantDisplayName),
                          ),
                        );
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
