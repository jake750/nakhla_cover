import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:gabes_eco_watch/models/report.dart';
import 'package:gabes_eco_watch/providers/auth_provider.dart';
import 'package:gabes_eco_watch/providers/report_provider.dart';
import 'package:gabes_eco_watch/services/firebase_service.dart';
import 'package:uuid/uuid.dart';

class ReportSubmissionForm extends StatefulWidget {
  const ReportSubmissionForm({super.key});

  @override
  _ReportSubmissionFormState createState() => _ReportSubmissionFormState();
}

class _ReportSubmissionFormState extends State<ReportSubmissionForm> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'Chemical Waste';
  String _description = '';
  File? _image;
  Position? _position;
  bool _isAnonymous = false;

  final List<String> _categories = [
    'Chemical Waste',
    'Plastic',
    'Dead Marine Life',
    'Air Smoke',
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    _position = await Geolocator.getCurrentPosition();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate() || _image == null || _position == null) return;

    _formKey.currentState!.save();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final firebaseService = FirebaseService();

    final uuid = Uuid();
    final reportId = uuid.v4();
    final imageUrl = await firebaseService.uploadImage(_image!.path, reportId);

    final report = Report(
      id: reportId,
      userId: _isAnonymous ? 'anonymous' : authProvider.user!.uid,
      category: _category,
      description: _description,
      latitude: _position!.latitude,
      longitude: _position!.longitude,
      imageUrl: imageUrl,
      timestamp: DateTime.now(),
      isAnonymous: _isAnonymous,
    );

    await reportProvider.submitReport(report);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Pollution'),
        backgroundColor: Color(0xFF005F73),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                initialValue: _category,
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (value) => setState(() => _category = value!),
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 20),
              _image == null
                  ? ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Take Photo'),
                    )
                  : Image.file(_image!),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text('Submit anonymously'),
                value: _isAnonymous,
                onChanged: (value) => setState(() => _isAnonymous = value!),
              ),
              ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF99AD7A)),
                child: Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}