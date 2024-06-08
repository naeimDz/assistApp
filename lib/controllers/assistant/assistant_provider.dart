import 'package:assistantsapp/controllers/enterprise/enterprise_provider.dart';
import 'package:flutter/material.dart';
import '../../models/assistant.dart';
import 'assistant_controller.dart';

class AssistantProvider with ChangeNotifier {
  final AssistantController _assistantController = AssistantController();
  List<Assistant> _assistants = [];
  List<Assistant> _filteredAssistants = [];
  Assistant? _selectedAssistant;

  List<Assistant> get assistants => _assistants;
  List<Assistant> get filteredAssistants => _filteredAssistants;
  Assistant? get selectedAssistant => _selectedAssistant;

  Future<List<Assistant>> fetchAssistants() async {
    _assistants = await _assistantController.getAssistants();
    _filteredAssistants = _assistants;
    notifyListeners();
    return _assistants;
  }

  Future<void> selectAssistant(String id) async {
    _selectedAssistant = await _assistantController.getAssistantById(id);
    notifyListeners();
  }

  Future<void> nullAssistant(Assistant? assistant) async {
    _selectedAssistant = assistant;
    //notifyListeners();
  }

  Future<void> addAssistant(Assistant assistant) async {
    await _assistantController.addAssistant(assistant);
    await fetchAssistants();
  }

  Future<void> updateAssistant(Assistant assistant) async {
    await _assistantController.updateAssistant(assistant);
    await fetchAssistants();
  }

  Future<void> deleteAssistant(String id) async {
    await _assistantController.deleteAssistant(id);
    await fetchAssistants();
  }

  void filterAssistants(String filter) {
    if (filter == 'All') {
      _filteredAssistants = _assistants;
    } else if (filter == 'Enterprise') {
      EnterpriseProvider().fetchEnterprises();
    } else {
      _filteredAssistants = _assistants
          .where((assistant) => assistant.serviceType == filter)
          .toList();
    }
    notifyListeners();
  }

  List<Assistant> get getFilteredAssistants => _filteredAssistants;
}
