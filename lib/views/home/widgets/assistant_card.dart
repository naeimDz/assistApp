import 'package:assistantsapp/controllers/assistant/assistant_provider.dart';
import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:assistantsapp/utils/constants/app_defaults.dart';
import 'package:assistantsapp/utils/constants/sizedbox_const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/assistant.dart';
import '../../sharedwidgets/circle_avatar.dart';

class AssistantCard extends StatelessWidget {
  final Assistant serviceProvider;
  final String nextScreen;
  const AssistantCard(
      {super.key, required this.serviceProvider, required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AssistantProvider>(context, listen: false)
            .selectAssistant(serviceProvider.id);
        Navigator.pushNamed(context, nextScreen);
      },
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: AppDefaults.borderRadius,
          boxShadow: AppDefaults.boxShadow,
        ),
        child: Container(
          height: 240,
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  circleAvatar(
                      serviceProvider.imageUrl, serviceProvider.firstName,
                      radius: 40),
                  AppSizedBox.w15,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${serviceProvider.firstName} ${serviceProvider.lastName}',
                          style: const TextStyle(
                            color: AppColors.blackText,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          serviceProvider.serviceType.name,
                          style: const TextStyle(
                            color: AppColors.blackText,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSizedBox.h15,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "•  ${serviceProvider.address.toString()} ",
                    style: const TextStyle(
                      color: AppColors.greyedTextColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Joined ${DateFormat.yMMMd().format(serviceProvider.joinDate!)}",
                    style: const TextStyle(
                      color: AppColors.greyedTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (serviceProvider.isValidated!)
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
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: phoneNumber,
                        );
                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
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
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: serviceProvider.email));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('email Copied to clipboard!')),
                      );
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
