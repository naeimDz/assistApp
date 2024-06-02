import 'dart:io';

import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage firebase_storage = FirebaseStorage.instance;

  // Getters for easier access to Firestore and FirebaseAuth instances
  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  // Stream to listen for changes in the current user's data (optional)
  Stream<DocumentSnapshot<Map<String, dynamic>>>? getCurrentUserDataStream() {
    var role = SharedPreferencesManager.getUserRole();
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    if (role != "user") {
      return _firestore
          .collection('users')
          .doc(uid)
          .snapshots(); // Replace 'users' with your actual collection name
    } else if (role != "assistant") {
      return _firestore.collection('providers').doc(uid).snapshots();
    } else {
      return _firestore.collection('enterprises').doc(uid).snapshots();
    }
  }

  // Function to fetch all documents  from a specific collection
  Future<QuerySnapshot<Map<String, dynamic>>?> getAllDocuments(
      String collectionPath) async {
    final snapshot = await _firestore.collection(collectionPath).get();
    return snapshot;
  }

  // Function to fetch a document by ID from a specific collection
  Future<DocumentSnapshot<Map<String, dynamic>>?> getDocumentById(
      String collectionPath, String documentId) async {
    final snapshot =
        await _firestore.collection(collectionPath).doc(documentId).get();
    return snapshot;
  }

  // Function to create a new document in a collection (consider error handling and validation)
  Future<void> createDocument(String collectionPath, String documentId,
      Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).doc(documentId).set(data);
  }

  // Function to update a document in a collection (consider error handling and validation)
  Future<void> updateDocument(String collectionPath, String documentId,
      Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).doc(documentId).update(data);
  }

  // Function to delete a document from a collection (consider error handling)
  Future<void> deleteDocument(String collectionPath, String documentId) async {
    await _firestore.collection(collectionPath).doc(documentId).delete();
  }

  Future<void> updateUserPhoto(File imageFile) async {
    try {
      // Get the current user
      final user = _auth.currentUser;

      if (user == null) {
        throw Exception('No user signed in.');
      }

      // Get the file name using null-safe operator
      final fileName =
          imageFile.path.split('/').last; // Assuming path separator is '/'

      // Reference to the image file in Firebase Storage
      final storageRef =
          firebase_storage.ref().child('profile_images').child(fileName);

      // Upload the image file to Firebase Storage
      await storageRef.putFile(imageFile);

      // Get the download URL for the image
      final downloadURL = await storageRef.getDownloadURL();

      // Update the user's photo URL
      await user.updatePhotoURL(downloadURL);

      print('User photo updated successfully.');
    } catch (e) {
      print('Error updating user photo: $e');
      throw e; // Re-throw for further handling
    }
  }
}
