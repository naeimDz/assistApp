import 'package:assistantsapp/models/subscription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Subscription>> getPendingInvitations(String associationId) {
    return _firestore
        .collection('subscription')
        .where('associationId', isEqualTo: associationId)
        .where('isApproved', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Subscription.fromFirestore(doc.data());
      }).toList();
    });
  }

  Future<void> updateInvitationStatus(String invitationId, bool status) async {
    await _firestore.collection('subscription').doc(invitationId).update({
      'isApproved': true,
    });
  }

  Future<void> sendSubscription(
      {required String userId,
      required String associationId,
      required String userName,
      bool? isAssistant}) async {
    final docRef = _firestore.collection('subscription').doc(userId);
    final newSubscription = Subscription(
        isAssistant: isAssistant ?? false,
        id: docRef.id,
        userId: userId,
        associationId: associationId,
        userName: userName,
        isApproved: false);
    await docRef.set(newSubscription.tomap());
  }
}
