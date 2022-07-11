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
    apiKey: 'AIzaSyAMs7unPUXKdsFTYlzn0mswvHfm8yVx3Bg',
    appId: '1:108236549198:web:5874c6d8c3aa1449e6671f',
    messagingSenderId: '108236549198',
    projectId: 'algo-f34c5',
    authDomain: 'algo-f34c5.firebaseapp.com',
    storageBucket: 'algo-f34c5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfSjHGaFo-Y05BZLcOOdWu3qYQuR4hys8',
    appId: '1:108236549198:android:bb0f281f4c50ef17e6671f',
    messagingSenderId: '108236549198',
    projectId: 'algo-f34c5',
    storageBucket: 'algo-f34c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9Yp0hJJKdzQ_lwF355D3AI6VEAbGMdBI',
    appId: '1:108236549198:ios:b2f8f96691fbf4d5e6671f',
    messagingSenderId: '108236549198',
    projectId: 'algo-f34c5',
    storageBucket: 'algo-f34c5.appspot.com',
    iosClientId: '108236549198-af9iocuenhphpghs5fqp92efobqf0k89.apps.googleusercontent.com',
    iosBundleId: 'com.example.learnearn',
  );
}
