import 'package:assistantsapp/models/service_type.dart';
import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:assistantsapp/utils/constants/sizedbox_const.dart';
import 'package:assistantsapp/views/home/widgets/assistant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/list_assistant.dart';
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
        //height: 40,
        decoration: BoxDecoration(
          color:
              optionSelected[index] ? AppColors.primary : AppColors.cardColor,
          borderRadius: AppDefaults.borderRadius,
          boxShadow: AppDefaults.boxShadow,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: Icon(
                Icons.man_4_outlined,
                color: optionSelected[index] ? Colors.white : Colors.black,
              ),
            ),
            AppSizedBox.w5,
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
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text("hello, Naeim", style: AppTextStyles.h1),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "lets find your assistant",
                  style: AppTextStyles.h4,
                ),
              ),
              AppSizedBox.h20,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    3, // Number of options
                    (index) =>
                        option(ServiceType.values.elementAt(index).name, index),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSizedBox.h15,
        Consumer<ListAssistant>(builder: (context, listAssistant, child) {
          return Wrap(
            // Use Wrap instead of Row for better multiline behavior
            children: List.generate(
              listAssistant.listAssistants
                  .length, // Define a variable for number of cards
              (index) => AssistantCard(
                serviceProvider: listAssistant.listAssistants[index],
                // Pass any properties needed by the AssistantCard widget here
              ),
            ),
          );
        }),
      ],
    );
  }
}
