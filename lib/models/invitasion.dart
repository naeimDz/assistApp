enum SubscriptionType { enterpriseToAssistant, assistantToClient }

class Subscription {
  final String id;
  final String senderId; // Can be enterprise or assistant ID based on type
  final String recipientId; // Can be assistant or client ID based on type
  final SubscriptionType type;
  final String status; // e.g., "pending", "accepted", "rejected"
  final DateTime createdAt; // Use DateTime.now() for creation time

  const Subscription({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.type,
    required this.status,
    required this.createdAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw FormatException('Subscription data is null or empty');
    }

    return Subscription(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      recipientId: json['recipientId'] as String,
      type: SubscriptionType.values.byName(json['type'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'senderId': senderId,
        'recipientId': recipientId,
        'type': type.name,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };
}
