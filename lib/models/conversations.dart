import 'message.dart';

class Conversation {
  final String assistantDisplayName;
  final String assistantId;
  final String lastMessage;
  final String userDisplayName;
  final String userId;
  final List<Message> messages;

  const Conversation({
    required this.assistantDisplayName,
    required this.assistantId,
    required this.lastMessage,
    required this.userDisplayName,
    required this.userId,
    required this.messages,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      assistantDisplayName: json['assistantDisplayName'] as String,
      assistantId: json['assistantId'] as String,
      lastMessage: json['lastMessage'] as String,
      userDisplayName: json['userDisplayName'] as String,
      userId: json['userId'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((message) => Message.fromJson(message))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        'assistantDisplayName': assistantDisplayName,
        'assistantId': assistantId,
        'lastMessage': lastMessage,
        'userDisplayName': userDisplayName,
        'userId': userId,
        'messages': messages.map((message) => message.toJson()).toList(),
      };
}
