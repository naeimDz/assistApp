import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:assistantsapp/utils/constants/app_defaults.dart';
import 'package:assistantsapp/utils/constants/sizedbox_const.dart';
import 'package:flutter/material.dart';

class AssistantCard extends StatelessWidget {
  const AssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      decoration: BoxDecoration(
        boxShadow: AppDefaults.boxShadow,
      ),
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
            color: AppColors.cardColor, borderRadius: AppDefaults.borderRadius),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.placeholder,
                ),
                AppSizedBox.w15,
                Text(
                  "First name + Last name",
                  style: TextStyle(
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
              "ain beida /28 years",
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
    );
  }
}
