// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD9LSCQg6H3VMp7X5huW0-2ZpVBnZHHN8E',
    appId: '1:966780269075:web:80e487cbf3d76126af05e6',
    messagingSenderId: '966780269075',
    projectId: 'fir-aapp-d88cf',
    authDomain: 'fir-aapp-d88cf.firebaseapp.com',
    storageBucket: 'fir-aapp-d88cf.appspot.com',
    measurementId: 'G-S87ENTLGZR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGi98yAjq64yzvwvjLvitFELkTw6zTz-4',
    appId: '1:966780269075:android:795887a37748c97daf05e6',
    messagingSenderId: '966780269075',
    projectId: 'fir-aapp-d88cf',
    storageBucket: 'fir-aapp-d88cf.appspot.com',
  );
}
