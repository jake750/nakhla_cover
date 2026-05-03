import 'package:flutter/material.dart';
import 'package:gabes_eco_watch/models/report.dart';
import 'package:gabes_eco_watch/services/firebase_service.dart';

class ReportProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Report> _reports = [];

  List<Report> get reports => _reports;

  ReportProvider() {
    _loadReports();
  }

  void _loadReports() {
    _firebaseService.getReports().listen((reports) {
      _reports = reports;
      notifyListeners();
    });
  }

  Future<void> submitReport(Report report) async {
    await _firebaseService.submitReport(report);
    // Optionally update local list
  }
}