// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
        return windows;
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
    apiKey: 'AIzaSyCCPlZZ-Tez1O3X47gGDqm4l76FC_4EemA',
    appId: '1:1012949830213:web:cb03907fc59e5bdbc8b12c',
    messagingSenderId: '1012949830213',
    projectId: 'rotigolovers-d7e9b',
    authDomain: 'rotigolovers-d7e9b.firebaseapp.com',
    storageBucket: 'rotigolovers-d7e9b.firebasestorage.app',
    measurementId: 'G-3MTW9ZPV4Z',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCCPlZZ-Tez1O3X47gGDqm4l76FC_4EemA',
    appId: '1:1012949830213:web:30601dbba1ad551ec8b12c',
    messagingSenderId: '1012949830213',
    projectId: 'rotigolovers-d7e9b',
    authDomain: 'rotigolovers-d7e9b.firebaseapp.com',
    storageBucket: 'rotigolovers-d7e9b.firebasestorage.app',
    measurementId: 'G-SC1JLT9968',
  );

}