class Message {
// Maintain consistency with original naming
  final String senderUid;
  final String senderDisplayName;
  final String receiverUid;
  final String receiverDisplayName;
  final String content;
  final DateTime timestamp;
  // Optional for identifying assistant messages

  const Message({
    required this.senderUid,
    required this.senderDisplayName,
    required this.receiverUid,
    required this.receiverDisplayName,
    required this.content,
    required this.timestamp,
// Set default to false
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderUid: json['senderUid'] as String,
      receiverUid: json['receiverUid'] as String,
      content: json['content'] as String,
      receiverDisplayName: json['receiverDisplayName'],
      senderDisplayName: json['senderDisplayName'],
      timestamp: DateTime.parse(json['timestamp'] as String),

// Default to false if not provided
    );
  }
  Map<String, dynamic> toJson() => {
        'senderUid': senderUid,
        'receiverUid': receiverUid,
        'content': content,
        'senderDisplayName': senderDisplayName,
        'receiverDisplayName': receiverDisplayName,
        'timestamp': timestamp
            .toIso8601String(), // Use toIso8601String for consistent formatting
      };
}
