import 'package:assistantsapp/models/subscription.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Replace with actual sender's image URL
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sender: ${invitation.userId}', // Replace with actual sender's name
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Status: ${invitation.isApproved}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Invitation Message or Details
            Text(
              'Invitation details go here. This could be a brief message or additional information about the invitation.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
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
                  child: Text('Accept'),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () async {
                    /*await Provider.of<InvitationProvider>(context,
                            listen: false)
                        .denyInvitation(invitation.id);*/
                  },
                  child: Text('Deny'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
