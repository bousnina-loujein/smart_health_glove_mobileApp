SMART HEALTH GLOVE — Flutter + Firebase Starter
===============================================

This zip contains a minimal Flutter app wired for Firebase Auth + Firestore + a live dashboard list.
Use it as a starting point for your Smart Health Glove mobile app.

Quick Start
-----------
1) Create a new Flutter project (to generate android/ ios/ tooling):
   flutter create smart_health_glove

2) Replace files:
   - Overwrite the new project's pubspec.yaml with the one from this zip.
   - Replace the entire lib/ folder with the lib/ from this zip.

3) Add Firebase to your app:
   - In the Firebase Console: create a project, then add Android (and iOS if needed).
   - Download google-services.json (Android) and place it at android/app/google-services.json.
     For iOS, place GoogleService-Info.plist at ios/Runner/GoogleService-Info.plist.
   - Run: dart pub global activate flutterfire_cli
          flutterfire configure
     This generates lib/firebase_options.dart automatically.

4) Install packages and run:
   flutter pub get
   flutter run

How it works
------------
- Email/password authentication via Firebase Auth.
- A Dashboard screen that streams the latest 50 docs from:
  users/{uid}/glove_readings ordered by ts desc
- A "Simulate" FAB to inject fake readings for testing (no ESP32 required).

Next Steps
----------
- From your ESP32, write sensor data to Firestore at:
  users/{uid}/glove_readings with fields: ts (Timestamp), finger, angle, tremor

Security
--------
- In Firebase Console → Firestore → Rules, restrict reads/writes to authenticated users:
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      match /users/{uid}/{document=**} {
        allow read, write: if request.auth != null && request.auth.uid == uid;
      }
    }
  }

Enjoy and build on!
