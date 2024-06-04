import 'package:assistantsapp/models/subscription.dart';
import 'package:flutter/material.dart';

class InvitationCard extends StatelessWidget {
  final Subscription invitation;

  InvitationCard({required this.invitation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sender Information
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Replace with actual sender's image URL
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sender: ${invitation.userId}', // Replace with actual sender's name
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Status: ${invitation.isApproved}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Invitation Message or Details
            const Text(
              'Invitation details go here. This could be a brief message or additional information about the invitation.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    /* await Provider.of<InvitationProvider>(context,
                            listen: false)
                        .acceptInvitation(invitation.id);*/
                  },
                  child: const Text('Accept'),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () async {
                    /*await Provider.of<InvitationProvider>(context,
                            listen: false)
                        .denyInvitation(invitation.id);*/
                  },
                  child: const Text('Deny'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
