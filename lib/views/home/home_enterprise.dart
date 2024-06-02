/*
import 'package:assistantsapp/models/subscription.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/association/list_clients_for_enterprise.dart';
import 'package:assistantsapp/views/sharedwidgets/list_assistants_for_enterprise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/assistant/assistant_provider.dart';
import '../../controllers/subscription_controller.dart';
import '../../models/assistant.dart';
import '../../services/shared_preferences_manager.dart';
import '../../utils/constants/app_text_styles.dart';
import '../sharedwidgets/segment_options.dart';
import 'widgets/assistant_card.dart';

class HomeEnterprise extends StatefulWidget {
  const HomeEnterprise({super.key});

  @override
  State<HomeEnterprise> createState() => _HomeEnterpriseState();
}

class _HomeEnterpriseState extends State<HomeEnterprise> {
  int _selectedIndex = 0; // Track the selected index
  var role = SharedPreferencesManager.getUserRole();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(17.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text("HI, there", style: AppTextStyles.h1),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                "",
                style: AppTextStyles.body,
              ),
            ),
          ]),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedOptions(
            options: const [
              "all Assistant",
              "MyClients",
              "MyAssistant",
              "Invitations"
            ],
            onChanged: (index) {
              setState(() {
                _selectedIndex = index; // Update the selected index
              });
            },
          ),
        ),
        if (_selectedIndex == 0)
          FutureBuilder<List<Assistant>>(
            future: AssistantProvider().assistants,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              var assistants = snapshot.data;
              if (assistants == null || assistants.isEmpty) {
                return const Text('No service providers available.');
              }

              return Wrap(
                children: assistants.map((Assistant assistant) {
                  return AssistantCard(
                    serviceProvider: assistant,
                  );
                }).toList(),
              );
            },
          ),
        if (_selectedIndex == 2)
          ListOfAssist(
            enterpriseId: id,
          ),
        if (_selectedIndex == 1)
          ListOfClients(
            enterpriseId: id,
          ),
        if (_selectedIndex == 3)
          ListOfInvitaions(
            enterpriseId: id,
          ),
      ],
    );
  }
}

class ListOfInvitaions extends StatelessWidget {
  final String enterpriseId;
  const ListOfInvitaions({super.key, required this.enterpriseId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Subscription>>(
      stream: SubscriptionController().getPendingInvitations(enterpriseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No pending invitations.'));
        }

        final subscriptions = snapshot.data!;
        if (subscriptions.isEmpty) {
          return const Text('No invitations available.');
        }
        return Wrap(
          children: subscriptions.map((Subscription subscription) {
            return InvitationCard(subscription: subscription);
          }).toList(),
        );
      },
    );
  }
}

class InvitationCard extends StatelessWidget {
  final Subscription subscription;

  const InvitationCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          if (subscription.role == "Assistant") {
            // Update the serviceProvider in the controller
            await Provider.of<AssistantControllerProvider>(context,
                    listen: false)
                .fetchassistantById(subscription.id!);
            // Navigate to the profile detail screen with a custom widget
            Navigator.pushNamed(
              context,
              RouteNameStrings.profileDetailScreen,
              arguments: const SizedBox(), // Pass your custom widget here
            );
          }
        } catch (e) {
          print('Error setting assistant: $e');
          // Handle error
        }
      },
      child: Card(
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
                  /* const CircleAvatar(
                    backgroundImage: serviceProvider.imageUrl != null
                          ? NetworkImage(serviceProvider.imageUrl!)
                          :  AssetImage("assets/images/profile.png")
                              as ImageProvider, // Replace with actual sender's image URL
                  ),*/
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sender: ${subscription.userName}', // Replace with actual sender's name
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Status: ${subscription.isApproved}',
                        style: TextStyle(
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
              SizedBox(height: 20),
              // Action Buttons
              /* TextButton(
                onPressed: () async {
                  EnterpriseControllerProvider().addToEnterprise(
                      subscription.associationId,
                      subscription.userId,
                      subscription.role);
                  SubscriptionController()
                      .updateInvitationStatus(subscription.id!, true);
                },
                child: Text('Accept'),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
*/