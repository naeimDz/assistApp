import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/shared_preferences_manager.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Map<String, dynamic> _currentUser;
  Map<String, dynamic> get currentUser => _currentUser;

  AuthService() {
    _currentUser = {}; // Initialize with an empty map
    initializeCurrentUser();
  }
  Future<void> initializeCurrentUser() async {
    var role = SharedPreferencesManager.getUserRole();
    final uid = _auth.currentUser?.uid;

    if (uid != null) {
      var doc =
          await FirebaseFirestore.instance.collection(role).doc(uid).get();
      _currentUser = doc.data() as Map<String, dynamic>;
    } else {
      _currentUser = {}; // Set to an empty map if user is not logged in
    }
    notifyListeners();
  }

  // Stream to listen to authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Function to sign up a new user with email and password
  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (credential.user != null) {
        final user = credential.user!;
        notifyListeners();
        return user;
      } else {
        // Handle signup failure (e.g., throw exception or return null)
        throw Exception(
            'Signup failed'); // Or: return null; (if null is a valid return)
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific signup errors (e.g., weak password, email already in use)
      print('Signup error: ${e.code}');
      throw e; // Re-throw the exception for further handling
    } catch (e) {
      // Handle other exceptions
      print('Signup error: $e');
      throw e; // Re-throw the exception for further handling
    }
  }

  // Function to sign in an existing user with email and password
  Future<void> signin(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (credential.user != null) {
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific signin errors (e.g., invalid credentials, user not found)
      print('Signin error: ${e.code}');
    } catch (e) {
      // Handle other exceptions
      print('Signin error: $e');
    }
  }

  // Function to sign out the current user
  Future<void> signout() async {
    await _auth.signOut();
    notifyListeners();
  }

// Function to delete the currently signed-in user's account (consider warnings and confirmation)
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.delete();
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        // Handle specific delete account errors
        print('Delete account error: ${e.code}');
      } catch (e) {
        // Handle other exceptions
        print('Delete account error: $e');
      }
    }
  }
}
