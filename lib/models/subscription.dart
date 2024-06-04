class Subscription {
  final String? id;
  final String userId;
  final String userName;
  final String associationId;
  final bool isApproved;
  final bool isAssistant;

  Subscription(
      {this.id,
      required this.userId,
      required this.userName,
      required this.associationId,
      this.isApproved = false,
      this.isAssistant = false});

  factory Subscription.fromFirestore(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      associationId: json['associationId'],
      isApproved: json['isApproved'],
      isAssistant: json['isAssistant'],
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'userId': userId,
      'associationId': associationId,
      'isApproved': isApproved,
      'userName': userName,
      'isAssistant': isAssistant
    };
  }
}
