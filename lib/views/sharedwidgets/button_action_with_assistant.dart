import 'package:assistantsapp/controllers/enterprise/enterprise_provider.dart';
import 'package:assistantsapp/services/firestore_service.dart';
import 'package:flutter/material.dart';

class ButtonActionWithAssistant extends StatelessWidget {
  final String assistantId;
  const ButtonActionWithAssistant({super.key, required this.assistantId});

  @override
  Widget build(BuildContext context) {
    var enterpriseId = FirestoreService().auth.currentUser!.uid;
    return ElevatedButton(
      onPressed: () {
        EnterpriseProvider().addToEnterprise(enterpriseId, assistantId, true);
      },
      child: const Text('Make Appointment'),
    );
  }
}
