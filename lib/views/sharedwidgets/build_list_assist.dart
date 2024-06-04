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
      ...filteredAssistants
          .map((assistant) => AssistantCard(serviceProvider: assistant)),
    ],
  );
}
