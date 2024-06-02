class Conversation {
  final String? id;
  final String assistantDisplayName;
  final String assistantId;
  final String lastMessage;
  final String userDisplayName;
  final String userId;

  const Conversation({
    this.id,
    required this.assistantDisplayName,
    required this.assistantId,
    required this.lastMessage,
    required this.userDisplayName,
    required this.userId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json, {String? id}) {
    return Conversation(
      id: id,
      assistantDisplayName: json['assistantDisplayName'] as String,
      assistantId: json['assistantId'] as String,
      lastMessage: json['lastMessage'] as String,
      userDisplayName: json['userDisplayName'] as String,
      userId: json['userId'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        'assistantDisplayName': assistantDisplayName,
        'assistantId': assistantId,
        'lastMessage': lastMessage,
        'userDisplayName': userDisplayName,
        'userId': userId,
      };
}
