import 'package:flutter/material.dart';
import '../../models/client.dart';
import 'client_controller.dart';

class ClientProvider with ChangeNotifier {
  final ClientController _clientController = ClientController();
  List<Client> _clients = [];
  Client? _selectedClient;

  List<Client> get clients => _clients;
  Client? get selectedClient => _selectedClient;

  Future<void> fetchClients() async {
    _clients = await _clientController.getClients();
    notifyListeners();
  }

  Future<void> selectClient(String id) async {
    _selectedClient = await _clientController.getClientById(id);
    notifyListeners();
  }

  Future<void> nullClient(Client? client) async {
    _selectedClient = client;
    notifyListeners();
  }

  Future<void> addClient(Client client) async {
    await _clientController.addClient(client);
    await fetchClients();
  }

  Future<void> updateClient(Client client) async {
    await _clientController.updateClient(client);
    await fetchClients();
  }

  Future<void> deleteClient(String id) async {
    await _clientController.deleteClient(id);
    await fetchClients();
  }
}
