import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationController _authController;

  AuthenticationState _state = AuthenticationState.unauthenticated;
  UserCredential? userCredential;
  AuthenticationProvider(this._authController);

  AuthenticationState get state => _state;

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      userCredential =
          await _authController.signUpWithEmailAndPassword(email, password);
      _state = AuthenticationState.authenticated;
      notifyListeners();
      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      userCredential =
          await _authController.signInWithEmailAndPassword(email, password);
      _state = AuthenticationState.authenticated;
      notifyListeners();
      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _authController.signOut();
      _state = AuthenticationState.unauthenticated;
      notifyListeners();
    } catch (e) {
      // Handle sign-out errors, if needed
      print("Error signing out: $e");
    }
  }
}

// authentication_state.dart
enum AuthenticationState { authenticated, unauthenticated }
