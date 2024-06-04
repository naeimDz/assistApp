import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:assistantsapp/controllers/enterprise/enterprise_provider.dart';
import 'package:assistantsapp/controllers/assistant/assistant_provider.dart';
import 'package:assistantsapp/models/assistant.dart';
import 'package:assistantsapp/models/enterprise.dart';
import 'package:assistantsapp/models/enum/service_type.dart';
import 'package:assistantsapp/utils/constants/app_strings.dart';
import 'package:assistantsapp/utils/constants/sizedbox_const.dart';
import 'package:assistantsapp/utils/constants/app_text_styles.dart';

import 'package:assistantsapp/views/sharedwidgets/segment_options.dart';

import '../../../services/handle_snapshot.dart';
import '../../sharedwidgets/build_list_assist.dart';
import 'enterprise_card.dart';

class HeaderHome extends StatefulWidget {
  const HeaderHome({super.key});

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  String selectedServiceType = 'All';
  final List<String> options =
      ['All', 'Enterprise'] + ServiceType.values.map((e) => e.name).toList();

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
                child: Text("Hello, there", style: AppTextStyles.h1),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  AppStrings.letsFindYourAssistant.tr(),
                  style: AppTextStyles.h4,
                ),
              ),
              AppSizedBox.h20,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedOptions(
                  options: options,
                  onChanged: (index) =>
                      setState(() => selectedServiceType = options[index]),
                ),
              ),
            ],
          ),
        ),
        AppSizedBox.h15,
        if (selectedServiceType != 'Enterprise')
          FutureBuilder<List<Assistant>>(
            future: Provider.of<AssistantProvider>(context, listen: false)
                .fetchAssistants(),
            builder: (context, assistantSnapshot) {
              return handleSnapshot(context, assistantSnapshot,
                  (data) => buildAssistantList(data, selectedServiceType));
            },
          ),
        if (selectedServiceType == 'Enterprise' || selectedServiceType == 'All')
          FutureBuilder<List<Enterprise>>(
            future: Provider.of<EnterpriseProvider>(context, listen: false)
                .fetchEnterprises(),
            builder: (context, snapshot) {
              return handleSnapshot(
                  context, snapshot, (data) => _buildEnterpriseList(data));
            },
          ),
      ],
    );
  }

  Widget _buildEnterpriseList(List<Enterprise> listEnterprises) {
    return Column(
      children: listEnterprises
          .map((enterprise) => EnterpriseCard(
                enterprise: enterprise,
              ))
          .toList(), // Replace with your EnterpriseCard or similar widget
    );
  }
}
