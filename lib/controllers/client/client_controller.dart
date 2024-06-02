import 'package:assistantsapp/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/client.dart';

class ClientController {
  final FirestoreService _db = FirestoreService();
  final String collectionName = 'clients';

  // Fetch all clients
  Future<List<Client>> getClients() async {
    QuerySnapshot? snapshot = await _db.getAllDocuments(collectionName);
    return snapshot!.docs
        .map((doc) => Client.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Fetch a single client by ID
  Future<Client?> getClientById(String id) async {
    DocumentSnapshot? doc = await _db.getDocumentById(collectionName, id);
    if (doc!.exists) {
      return Client.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Add a new client
  Future<void> addClient(Client client) async {
    await _db.createDocument(collectionName, client.id, client.toJson());
  }

  // Update an existing client
  Future<void> updateClient(Client client) async {
    await _db.updateDocument(collectionName, client.id, client.toJson());
  }

  // Delete a client
  Future<void> deleteClient(String id) async {
    await _db.deleteDocument(collectionName, id);
  }
}
