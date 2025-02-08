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
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyAFUNdnhkb5fwe1weDS7iHfY6PoEwXugBY',
    appId: '1:732829900420:web:206d0189e7fd20a202ecd1',
    messagingSenderId: '732829900420',
    projectId: 'ecopulse-f52e3',
    authDomain: 'ecopulse-f52e3.firebaseapp.com',
    storageBucket: 'ecopulse-f52e3.firebasestorage.app',
    measurementId: 'G-X2CZ5E8Z3B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkr5zKh1OS0sMElT_Pp7MHJ0gWux7BnPw',
    appId: '1:732829900420:android:35a05e521797297402ecd1',
    messagingSenderId: '732829900420',
    projectId: 'ecopulse-f52e3',
    storageBucket: 'ecopulse-f52e3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB89_LvrviAVaFDcgal4bOOZKRps2vdIxY',
    appId: '1:732829900420:ios:137d8d8f722fbe5502ecd1',
    messagingSenderId: '732829900420',
    projectId: 'ecopulse-f52e3',
    storageBucket: 'ecopulse-f52e3.firebasestorage.app',
    iosBundleId: 'com.example.ecoPulse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB89_LvrviAVaFDcgal4bOOZKRps2vdIxY',
    appId: '1:732829900420:ios:137d8d8f722fbe5502ecd1',
    messagingSenderId: '732829900420',
    projectId: 'ecopulse-f52e3',
    storageBucket: 'ecopulse-f52e3.firebasestorage.app',
    iosBundleId: 'com.example.ecoPulse',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAFUNdnhkb5fwe1weDS7iHfY6PoEwXugBY',
    appId: '1:732829900420:web:9f36f2c95464ed9202ecd1',
    messagingSenderId: '732829900420',
    projectId: 'ecopulse-f52e3',
    authDomain: 'ecopulse-f52e3.firebaseapp.com',
    storageBucket: 'ecopulse-f52e3.firebasestorage.app',
    measurementId: 'G-9SK48HNPYQ',
  );
}
