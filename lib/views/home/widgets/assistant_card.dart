import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:assistantsapp/utils/constants/app_defaults.dart';
import 'package:assistantsapp/utils/constants/sizedbox_const.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/assistant.dart';
import '../../../providers/list_assistant.dart';

class AssistantCard extends StatelessWidget {
  final ServiceProvider serviceProvider;
  const AssistantCard({super.key, required this.serviceProvider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ListAssistant>(context, listen: false)
            .setCurrentAssistant(serviceProvider);
        Navigator.pushNamed(context, RouteNameStrings.profileDetailScreen);
      },
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        decoration: BoxDecoration(
          boxShadow: AppDefaults.boxShadow,
        ),
        child: Container(
          height: 170,
          padding: const EdgeInsets.all(AppDefaults.padding),
          decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: AppDefaults.borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.placeholder,
                  ),
                  AppSizedBox.w15,
                  Text(
                    "${serviceProvider.firstName} ${serviceProvider.lastName}",
                    style: const TextStyle(
                      color: AppColors.blackText,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
              Text(
                "${serviceProvider.city} / ${serviceProvider.joinDate}",
                style: TextStyle(
                  color: AppColors.greyedTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppSizedBox.h15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.verified_outlined),
                  Icon(Icons.call),
                  Icon(Icons.email),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
