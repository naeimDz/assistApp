import 'package:assistantsapp/controllers/provider_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ServiceProviderController _serviceProviderController =
      ServiceProviderController();
  AuthenticationController();

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _serviceProviderController.createUserProfile(
          userCredential.user!.uid, email);
      return userCredential;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
      throw e;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("Error signing out: $e");
      return null; // Return null if authentication fails
    }
  }
}
