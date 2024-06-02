import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
// Maintain consistency with original naming
  final String senderUid;
  final String? senderDisplayName;
  final String? receiverUid;
  final String? receiverDisplayName;
  final String content;
  final Timestamp timestamp;
  // Optional for identifying assistant messages

  const Message({
    required this.senderUid,
    this.senderDisplayName,
    this.receiverUid,
    this.receiverDisplayName,
    required this.content,
    required this.timestamp,
// Set default to false
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderUid: json['senderUid'] as String,
      receiverUid: json['receiverUid'] as String?,
      content: json['content'] as String,
      receiverDisplayName: json['receiverDisplayName'] as String?,
      senderDisplayName: json['senderDisplayName'] as String?,
      timestamp: json['timestamp'] as Timestamp,

// Default to false if not provided
    );
  }
  Map<String, dynamic> toJson() => {
        'senderUid': senderUid,
        'receiverUid': receiverUid,
        'content': content,
        'senderDisplayName': senderDisplayName,
        'receiverDisplayName': receiverDisplayName,
        'timestamp': timestamp.toDate()
      };
}
