import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gabes_eco_watch/services/firebase_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _authStateChanges();
  }

  void _authStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    _user = await _firebaseService.signInWithGoogle();
    notifyListeners();
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    _user = await _firebaseService.signInWithPhone(phoneNumber);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
    _user = null;
    notifyListeners();
  }
}