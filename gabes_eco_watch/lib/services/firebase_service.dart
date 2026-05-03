import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gabes_eco_watch/models/report.dart';
import 'package:gabes_eco_watch/models/user.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Auth methods
  Future<User?> signInWithGoogle() async {
    // Implement Google Sign In
    // This requires google_sign_in package
    throw UnimplementedError('Google Sign In not implemented');
  }

  Future<User?> signInWithPhone(String phoneNumber) async {
    // Implement Phone Auth
    throw UnimplementedError('Phone Auth not implemented');
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Report methods
  Future<void> submitReport(Report report) async {
    await _firestore.collection('reports').doc(report.id).set(report.toMap());
  }

  Stream<List<Report>> getReports() {
    return _firestore.collection('reports').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Report.fromMap(doc.data())).toList();
    });
  }

  // User methods
  Future<void> updateUserProfile(UserProfile user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserProfile.fromMap(doc.data()!);
    }
    return null;
  }

  // Storage
  Future<String> uploadImage(String path, String fileName) async {
    final ref = _storage.ref().child('reports/$fileName');
    await ref.putFile(File(path));
    return await ref.getDownloadURL();
  }
}