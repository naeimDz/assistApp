import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/sharedwidgets/test_ad.dart';
import 'package:flutter/widgets.dart';

import '../../models/assistant.dart';
import '../home/widgets/assistant_card.dart';

Widget buildAssistantList(
    List<Assistant> listAssistant, String selectedServiceType) {
  var filteredAssistants = listAssistant.where((assistant) {
    if (selectedServiceType == 'All') return true;
    return assistant.serviceType.name == selectedServiceType;
  }).toList();

  return Column(
    children: [
      ...filteredAssistants.map((assistant) => AssistantCard(
            serviceProvider: assistant,
            nextScreen: RouteNameStrings.assistantDetailScreen,
          )),
      // Insert ad after every 3rd assistant (adjust as needed)
      if (filteredAssistants.length % 3 == 0 && filteredAssistants.isNotEmpty)
        BuildTestAd(),
    ],
  );
}
