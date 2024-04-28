import 'dart:io';
import 'package:assistantsapp/models/assistant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServiceProviderController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createUserProfile(String userId, String email) async {
    try {
      await _db.collection('providers').doc(userId).set({
        'email': email,
        // Add additional user data here
      });
    } catch (e) {
      print("Error creating user profile: $e");
      throw e;
    }
  }

  Future<void> updateServiceProvider(ServiceProvider ServiceProvider) async {
    try {
      await _db.collection('ServiceProviders').doc(ServiceProvider.id).update({
        'name': ServiceProvider.username,
        'phoneNumber': ServiceProvider.phoneNumber,
      });
    } catch (e) {
      print("Error updating ServiceProvider: $e");
      throw e;
    }
  }

  Future<ServiceProvider> getServiceProviderById(String id) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('ServiceProviders').doc(id).get();
      return ServiceProvider.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error getting ServiceProvider by id: $e');
      throw e;
    }
  }

  Future<void> uploadImage(String id, String imagePath) async {
    try {
      Reference ref =
          _storage.ref().child('ServiceProviders/$id/profile_picture.jpg');
      await ref.putFile(File(imagePath));
      String downloadURL = await ref.getDownloadURL();
      await _db
          .collection('ServiceProviders')
          .doc(id)
          .update({'imageUrl': downloadURL});
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  Future<List<ServiceProvider>> getAllServiceProviders() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('providers').get();

      return querySnapshot.docs
          .map((doc) => ServiceProvider.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting all ServiceProviders: $e');
      throw e;
    }
  }

  Future<void> deleteServiceProvider(String ServiceProviderUid) async {
    try {
      await _db.collection('ServiceProviders').doc(ServiceProviderUid).delete();
    } catch (e) {
      print("Error deleting ServiceProvider: $e");
      throw e;
    }
  }
}
