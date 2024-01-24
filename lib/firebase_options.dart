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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyDE4jixQ7WvkeLvD7e6jfCG1MCpoOKCmM0',
    appId: '1:613630834796:web:a0d0387f3b02655ab38049',
    messagingSenderId: '613630834796',
    projectId: 'facemosque-new',
    authDomain: 'facemosque-new.firebaseapp.com',
    storageBucket: 'facemosque-new.appspot.com',
    measurementId: 'G-5WVCGT3ZCQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzJzgAndqWzmR_4X1azCwyYxeW2d4opRQ',
    appId: '1:613630834796:android:e2f59285d13a4ee0b38049',
    messagingSenderId: '613630834796',
    projectId: 'facemosque-new',
    storageBucket: 'facemosque-new.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqK2QeVsigWImMEVhQVMIAqKQ9ExJ1BtI',
    appId: '1:613630834796:ios:e5b7fd2bc3fff1f6b38049',
    messagingSenderId: '613630834796',
    projectId: 'facemosque-new',
    storageBucket: 'facemosque-new.appspot.com',
    iosClientId: '613630834796-of7qnfbs2cu7kltehl1r3h1uriomoip8.apps.googleusercontent.com',
    iosBundleId: 'com.example.facemosqueadmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqK2QeVsigWImMEVhQVMIAqKQ9ExJ1BtI',
    appId: '1:613630834796:ios:e5b7fd2bc3fff1f6b38049',
    messagingSenderId: '613630834796',
    projectId: 'facemosque-new',
    storageBucket: 'facemosque-new.appspot.com',
    iosClientId: '613630834796-of7qnfbs2cu7kltehl1r3h1uriomoip8.apps.googleusercontent.com',
    iosBundleId: 'com.example.facemosqueadmin',
  );
}
