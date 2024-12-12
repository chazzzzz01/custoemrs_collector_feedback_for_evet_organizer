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
    apiKey: 'AIzaSyDcbWIMkTP6D6Dsz-55Cymq8MTrc2xquJk',
    appId: '1:642788872239:web:5bf9c4a1768e525fccf6da',
    messagingSenderId: '642788872239',
    projectId: 'customers-collector-feed-f260a',
    authDomain: 'customers-collector-feed-f260a.firebaseapp.com',
    storageBucket: 'customers-collector-feed-f260a.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0TH2pnjSE-f8NLqPsq3dQwkCF9RAkjog',
    appId: '1:642788872239:android:6e57e9b969a20b74ccf6da',
    messagingSenderId: '642788872239',
    projectId: 'customers-collector-feed-f260a',
    storageBucket: 'customers-collector-feed-f260a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKUt06FWkK38n1aEA-ZhIqcKebDbDpvWw',
    appId: '1:642788872239:ios:e581d74fccae3fd1ccf6da',
    messagingSenderId: '642788872239',
    projectId: 'customers-collector-feed-f260a',
    storageBucket: 'customers-collector-feed-f260a.firebasestorage.app',
    iosBundleId: 'com.example.customersCollectorFeedback',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKUt06FWkK38n1aEA-ZhIqcKebDbDpvWw',
    appId: '1:642788872239:ios:e581d74fccae3fd1ccf6da',
    messagingSenderId: '642788872239',
    projectId: 'customers-collector-feed-f260a',
    storageBucket: 'customers-collector-feed-f260a.firebasestorage.app',
    iosBundleId: 'com.example.customersCollectorFeedback',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDcbWIMkTP6D6Dsz-55Cymq8MTrc2xquJk',
    appId: '1:642788872239:web:5370c09f431ae332ccf6da',
    messagingSenderId: '642788872239',
    projectId: 'customers-collector-feed-f260a',
    authDomain: 'customers-collector-feed-f260a.firebaseapp.com',
    storageBucket: 'customers-collector-feed-f260a.firebasestorage.app',
  );

}