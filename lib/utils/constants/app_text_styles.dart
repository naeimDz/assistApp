import 'package:flutter/material.dart';

import 'screen_ratio.dart';

/// Class containing commonly used text styles for the app.
class AppTextStyles {
  static const String fontFamily = 'Dubai';

  static TextStyle pageHeaderBigTextStyle(
    BuildContext context, {
    Color? color,
    bool isBold = false,
    bool hasUnderline = false,
  }) =>
      TextStyle(
        fontSize: 34 * (ScreenRatio.fontRatio == 0 ? 1 : ScreenRatio.fontRatio),
        letterSpacing: 0.41 * ScreenRatio.widthRatio,
        fontWeight: isBold ? FontWeight.w800 : FontWeight.normal,
        decoration:
            hasUnderline ? TextDecoration.underline : TextDecoration.none,
        color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
      );

  // Title Text Styles
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
  );

  static TextStyle titleWithOpacity(bool opacity) => title.copyWith(
        color: opacity ? Colors.grey[400] : Colors.black,
      );

  // Heading Text Styles
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    fontSize: 30,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 25,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  // Body Text Styles
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
  );

  static const TextStyle bodySm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
  );

  static const TextStyle bodyLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  // Caption Text Style
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
  );
}
