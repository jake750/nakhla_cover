# Gabes Eco-Watch

A Flutter mobile application for reporting marine and environmental pollution in Gabes, Tunisia. Citizens can submit reports with photos, GPS coordinates, and descriptions, displayed on an interactive map.

## Features

- User authentication (Google or Phone)
- Anonymous reporting
- Camera integration for photo capture
- GPS location tagging
- Interactive Google Maps with clustered markers
- Clean architecture with Provider pattern
- Firebase backend (Auth, Firestore, Storage)

## Setup

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Clone the repository
3. Run `flutter pub get`
4. Configure Firebase:
   - Create a Firebase project
   - Add google-services.json (Android) and GoogleService-Info.plist (iOS)
   - Enable Authentication, Firestore, Storage
5. Run `flutter run`

## Dependencies

- firebase_core
- firebase_auth
- cloud_firestore
- firebase_storage
- google_maps_flutter
- geolocator
- camera
- image_picker
- provider
- uuid

## Architecture

- **models/**: Data models (Report, UserProfile)
- **providers/**: State management (AuthProvider, ReportProvider)
- **screens/**: UI screens (HomeMapScreen, ReportSubmissionForm)
- **services/**: Firebase services
- **widgets/**: Reusable widgets
