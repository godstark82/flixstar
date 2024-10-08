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
    apiKey: 'AIzaSyB1169YIDvX1e5sCq73CZbOibZz3lfzpWg',
    appId: '1:163571023666:web:6595539d744699a9d6212b',
    messagingSenderId: '163571023666',
    projectId: 'flixvibes-547e5',
    authDomain: 'flixvibes-547e5.firebaseapp.com',
    databaseURL: 'https://flixvibes-547e5-default-rtdb.firebaseio.com',
    storageBucket: 'flixvibes-547e5.appspot.com',
    measurementId: 'G-FG91Q1WNGY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeWHUZOQJiVkrSzdBeEr01Vsf6tZ59a9k',
    appId: '1:163571023666:android:a03f19f3dcb6d66cd6212b',
    messagingSenderId: '163571023666',
    projectId: 'flixvibes-547e5',
    databaseURL: 'https://flixvibes-547e5-default-rtdb.firebaseio.com',
    storageBucket: 'flixvibes-547e5.appspot.com',
  );

}