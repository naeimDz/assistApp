import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/enterprise.dart';
import 'enterprise_controller.dart';

class EnterpriseProvider with ChangeNotifier {
  final EnterpriseController _enterpriseController = EnterpriseController();
  List<Enterprise> _enterprises = [];
  Enterprise? _selectedEnterprise;

  List<Enterprise> get enterprises => _enterprises;
  Enterprise? get selectedEnterprise => _selectedEnterprise;

  Future<List<Enterprise>> fetchEnterprises() async {
    _enterprises = await _enterpriseController.getEnterprises();

    notifyListeners();

    return _enterprises;
  }

  Future<void> selectEnterprise(String id) async {
    _selectedEnterprise = await _enterpriseController.getEnterpriseById(id);
    notifyListeners();
  }

  Future<void> addEnterprise(Enterprise enterprise) async {
    await _enterpriseController.addEntrprise(enterprise);
    await fetchEnterprises();
  }

  Future<void> updateEnterprise(Enterprise enterprise) async {
    await _enterpriseController.updateEnterprise(enterprise);
    await fetchEnterprises();
  }

  Future<void> deleteEnterprise(String id) async {
    await _enterpriseController.deleteEnterprise(id);
    await fetchEnterprises();
  }

  Future<List<DocumentSnapshot>> fetchAppointments() async {
    if (_selectedEnterprise != null) {
      return await _enterpriseController
          .getDocuments(_selectedEnterprise!.appointments);
    }
    return [];
  }

  Future<List<DocumentSnapshot>> fetchAssistants(
      {Enterprise? selectedEnterprise}) async {
    if (_selectedEnterprise != null) {
      return await _enterpriseController
          .getDocuments(_selectedEnterprise!.assistants);
    }
    return [];
  }

  Future<List<DocumentSnapshot>> fetchClients(String id) async {
    await selectEnterprise(id);
    return await _enterpriseController
        .getDocuments(_selectedEnterprise!.clients);
  }

  Future<void> addToEnterprise(
      String enterpriseId, String id, String isAssistant) async {
    await _enterpriseController.addToEnterprise(enterpriseId, id, isAssistant);
  }
}
