class Message {
  final String messageId;
  final String senderUid;
  final String receiverUid;
  final String content;
  final DateTime timestamp;

  Message({
    required this.messageId,
    required this.senderUid,
    required this.receiverUid,
    required this.content,
    required this.timestamp,
  });
}
