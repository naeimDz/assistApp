import 'package:flutter/material.dart';
import '../../utils/constants/app_defaults.dart';
import '../../utils/constants/app_text_styles.dart';
import '../../utils/constants/sizedbox_const.dart';

class HeadlineRow extends StatelessWidget {
  const HeadlineRow({
    super.key,
    required this.headline,
    this.subtitle = "",
    this.width,
    this.fontColor,
    this.isHeader = true,
  });

  final String headline;
  final double? width;
  final Color? fontColor;
  final bool isHeader;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headline.trim(),
              style: isHeader ? AppTextStyles.h1 : AppTextStyles.h4),
          AppSizedBox.h5,
          Text(subtitle),
        ],
      ),
    );
  }
}
