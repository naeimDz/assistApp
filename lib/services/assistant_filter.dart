/*import 'package:assistantsapp/models/assistant.dart';
import 'package:assistantsapp/models/service_type.dart';

List<Assistant>? filterAssistants(
    List<Assistant>? serviceProviders, int selectedIndex) {
  if (selectedIndex == 0) {
    return serviceProviders; // Show all assistants if "All" is selected
  } else if (selectedIndex == 1) {
    return []; // Empty list if the "All" option is not selected
  } else {
    return serviceProviders
        ?.where((assistant) =>
            assistant.serviceType?.toLowerCase() ==
            ServiceType.values[selectedIndex - 2].name.toLowerCase())
        .toList();
  }
}
*/