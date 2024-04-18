import 'dart:io';
import 'package:assistantsapp/models/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProviderController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addProvider(Provider provider) async {
    try {
      await _db.collection('providers').doc(provider.id).set({
        'uid': provider.id,
        'email': provider.email,
        'name': provider.username,
        'phoneNumber': provider.phoneNumber,
      });
    } catch (e) {
      print("Error adding provider: $e");
      throw e;
    }
  }

  Future<void> updateProvider(Provider provider) async {
    try {
      await _db.collection('providers').doc(provider.id).update({
        'name': provider.username,
        'phoneNumber': provider.phoneNumber,
      });
    } catch (e) {
      print("Error updating provider: $e");
      throw e;
    }
  }

  Future<Provider> getProviderById(String id) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('providers').doc(id).get();
      return Provider.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error getting provider by id: $e');
      throw e;
    }
  }

  Future<void> uploadImage(String id, String imagePath) async {
    try {
      Reference ref = _storage.ref().child('providers/$id/profile_picture.jpg');
      await ref.putFile(File(imagePath));
      String downloadURL = await ref.getDownloadURL();
      await _db
          .collection('providers')
          .doc(id)
          .update({'imageUrl': downloadURL});
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  Future<List<Provider>> getAllProviders() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('providers').get();
      return querySnapshot.docs
          .map((doc) => Provider.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting all providers: $e');
      throw e;
    }
  }

  Future<void> deleteProvider(String providerUid) async {
    try {
      await _db.collection('providers').doc(providerUid).delete();
    } catch (e) {
      print("Error deleting provider: $e");
      throw e;
    }
  }
}
