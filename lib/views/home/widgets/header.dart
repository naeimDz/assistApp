import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/app_defaults.dart';
import '../../../utils/constants/app_text_styles.dart';

class HeaderHome extends StatefulWidget {
  const HeaderHome({super.key});

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  List<bool> optionSelected = [true, false, false];

  Widget option(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          optionSelected[index] = !optionSelected[index];
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color:
                optionSelected[index] ? AppColors.primary : AppColors.cardColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: AppDefaults.boxShadow),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            SizedBox(
                height: 32,
                width: 32,
                child: Icon(Icons.man_4_outlined,
                    color:
                        optionSelected[index] ? Colors.white : Colors.black)),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(
                color: optionSelected[index] ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    //child: buildTextTitleVariation1("Hello,Naeim")),

                    child: Text("hello, Naeim", style: AppTextStyles.h1)),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "lets find your assistant",
                    style: AppTextStyles.h4,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    option('baby', 0),
                    SizedBox(width: 8),
                    option('oldmen', 1),
                    SizedBox(width: 8),
                    option('animal', 2),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
