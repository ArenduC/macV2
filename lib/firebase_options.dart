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
    apiKey: 'AIzaSyAqRXjeu1KVXQ302CrAzW-sGCH5oZWw_Aw',
    appId: '1:667926745235:web:e17812f87daa242802bd66',
    messagingSenderId: '667926745235',
    projectId: 'maca-cf502',
    authDomain: 'maca-cf502.firebaseapp.com',
    storageBucket: 'maca-cf502.firebasestorage.app',
    measurementId: 'G-22H0LDD2KQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGJfho75PDN4xwnGoGU6CSlqjA82EK1FQ',
    appId: '1:667926745235:android:c71037e70b7dd4a502bd66',
    messagingSenderId: '667926745235',
    projectId: 'maca-cf502',
    storageBucket: 'maca-cf502.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiKbf7U0O-Mm0SIcPSoeGTC11hlC-zR30',
    appId: '1:667926745235:ios:32d0411e6c4b27b402bd66',
    messagingSenderId: '667926745235',
    projectId: 'maca-cf502',
    storageBucket: 'maca-cf502.firebasestorage.app',
    iosBundleId: 'com.example.maca',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiKbf7U0O-Mm0SIcPSoeGTC11hlC-zR30',
    appId: '1:667926745235:ios:32d0411e6c4b27b402bd66',
    messagingSenderId: '667926745235',
    projectId: 'maca-cf502',
    storageBucket: 'maca-cf502.firebasestorage.app',
    iosBundleId: 'com.example.maca',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAqRXjeu1KVXQ302CrAzW-sGCH5oZWw_Aw',
    appId: '1:667926745235:web:d06a220b6a6fccf902bd66',
    messagingSenderId: '667926745235',
    projectId: 'maca-cf502',
    authDomain: 'maca-cf502.firebaseapp.com',
    storageBucket: 'maca-cf502.firebasestorage.app',
    measurementId: 'G-09FCYNV8E5',
  );

}