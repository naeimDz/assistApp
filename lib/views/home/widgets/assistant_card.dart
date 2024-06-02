import 'package:assistantsapp/controllers/assistant/assistant_provider.dart';
import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:assistantsapp/utils/constants/app_defaults.dart';
import 'package:assistantsapp/utils/constants/sizedbox_const.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/assistant.dart';
import '../../sharedwidgets/circle_avatar.dart';

class AssistantCard extends StatelessWidget {
  final Assistant serviceProvider;

  const AssistantCard({super.key, required this.serviceProvider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AssistantProvider>(context, listen: false)
            .selectAssistant(serviceProvider.id);
        Navigator.pushNamed(context, RouteNameStrings.assistantDetailScreen);
      },
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: AppDefaults.borderRadius,
          boxShadow: AppDefaults.boxShadow,
        ),
        child: Container(
          height: 220,
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  circleAvatar(
                      serviceProvider.imageUrl, serviceProvider.firstName),
                  AppSizedBox.w15,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${serviceProvider.firstName} ${serviceProvider.lastName}',
                          style: const TextStyle(
                            color: AppColors.blackText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${serviceProvider.address?.city ?? 'Unknown City'} • Joined ${DateFormat.yMMMd().format(serviceProvider.joinDate?.toDate() ?? DateTime.now())}",
                          style: TextStyle(
                            color: AppColors.greyedTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.greyedTextColor,
                  ),
                ],
              ),
              const Spacer(),
              AppSizedBox.h15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (serviceProvider.isValidated)
                    IconButton(
                      icon:
                          const Icon(Icons.verified_sharp, color: Colors.green),
                      onPressed: () {},
                      tooltip: 'Verified',
                    ),
                  IconButton(
                    icon: const Icon(Icons.call,
                        color:
                            AppColors.primary), // Use your app's primary color
                    onPressed: () async {
                      // Handle call action with permissions and error handling
                      final phoneNumber = serviceProvider.phoneNumber;
                      if (phoneNumber?.isNotEmpty == true) {
                        final url = 'tel:$phoneNumber';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          // Handle cases where the phone cannot be launched (e.g., emulator)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Could not launch the phone app.')),
                          );
                        }
                      } else {
                        // Handle the case where the phone number is not available
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Phone number not available for this assistant.')),
                        );
                      }
                    },
                    tooltip:
                        'Call ${serviceProvider.phoneNumber}', // Dynamic tooltip with phone number
                  ),
                  IconButton(
                    icon: const Icon(Icons.email, color: AppColors.primary),
                    onPressed: () {
                      // Implement email action
                    },
                    tooltip: 'Email',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
