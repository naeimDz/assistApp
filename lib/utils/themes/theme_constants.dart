import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_defaults.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  /// A light theme for App
  static ThemeData get lightTheme => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      textTheme: ThemeData.light()
          .textTheme
          .apply(fontFamily: AppTextStyles.fontFamily),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      cardColor: AppColors.cardColor,
      canvasColor: AppColors.cardColor,
      listTileTheme: const ListTileThemeData(
        tileColor: AppColors.cardColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 5.0),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              color: AppColors.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all(Color.fromRGBO(123, 115, 231, 0.17)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDefaults.borderRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDefaults.borderRadius,
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
        fillColor: AppColors.cardColor,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.scaffoldBackground,
          ),
          iconTheme: IconThemeData(color: AppColors.blackText),
          titleTextStyle: TextStyle(
            color: AppColors.blackText,
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
          centerTitle: false),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.whiteText,
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.all(AppDefaults.padding),
          shape: RoundedRectangleBorder(
            borderRadius: AppDefaults.borderRadius,
          ),
        ),
      ),
      chipTheme: const ChipThemeData(
        labelStyle: TextStyle(
          color: AppColors.blackText,
        ),
        selectedColor: AppColors.primary,
        showCheckmark: true,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.all(AppDefaults.padding),
          shape: RoundedRectangleBorder(
            borderRadius: AppDefaults.borderRadius,
          ),
        ),
      ),
      tabBarTheme: TabBarTheme(
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: AppDefaults.padding,
          vertical: AppDefaults.padding / 1.15,
        ),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.cardColorDark.withOpacity(0.5),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle:
            const TextStyle(fontFamily: AppTextStyles.fontFamily),
      ));

  /// A Dark theme for App
  static ThemeData get darkTheme => ThemeData(
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: AppTextStyles.fontFamily,
              displayColor: Colors.white,
              bodyColor: Colors.white,
            ),
        cardColor: AppColors.cardColorDark,
        scaffoldBackgroundColor: AppColors.scaffoldBackgrounDark,
        canvasColor: AppColors.cardColorDark,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.0),
              borderSide: const BorderSide(color: Colors.grey)),
          labelStyle: const TextStyle(color: AppColors.greyedTextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
        ),
        iconTheme: const IconThemeData(color: AppColors.primary),
        listTileTheme: const ListTileThemeData(iconColor: AppColors.primary),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.scaffoldBackgrounDark,
          elevation: 0,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.scaffoldBackgrounDark,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: AppTextStyles.fontFamily,
          ),
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.all(AppDefaults.padding),
            shape: RoundedRectangleBorder(
              borderRadius: AppDefaults.borderRadius,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            padding: const EdgeInsets.all(AppDefaults.padding),
            shape: RoundedRectangleBorder(
              borderRadius: AppDefaults.borderRadius,
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              color: AppColors.primary,
            ),
          ),
          labelPadding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding / 1.15,
          ),
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.cardColor.withOpacity(0.5),
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle:
              const TextStyle(fontFamily: AppTextStyles.fontFamily),
        ),
      );
}
