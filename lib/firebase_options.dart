// GENERATED FILE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names, public_member_api_docs

import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Default [FirebaseOptions] for supported platforms.
///
/// This is a simplified generated file created from your Android
/// `google-services.json`. It provides Android options and placeholder
/// values for other platforms. If you use other platforms, replace the
/// placeholders or run `flutterfire configure` to generate a complete file.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    if (Platform.isAndroid) return android;
    if (Platform.isIOS || Platform.isMacOS) return ios;
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAypFnzY7QMXJjq758v9a1JbYWNVCL2Tbo',
    appId: '1:815014262533:android:19723b154b34eff47ce96c',
    messagingSenderId: '815014262533',
    projectId: 'smartglove-7db11',
    storageBucket: 'smartglove-7db11.firebasestorage.app',
    databaseURL: 'https://smartglove-7db11-default-rtdb.firebaseio.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    authDomain: '',
    storageBucket: '',
    measurementId: '',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    storageBucket: '',
  );
}
