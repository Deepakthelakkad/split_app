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
    apiKey: 'AIzaSyA9msML4EBhI8tDNdKYs9P6d7WnRicAoTw',
    appId: '1:1054794976066:web:11206cfa287ac8b68e96db',
    messagingSenderId: '1054794976066',
    projectId: 'splitexpence-7db38',
    authDomain: 'splitexpence-7db38.firebaseapp.com',
    storageBucket: 'splitexpence-7db38.appspot.com',
    measurementId: 'G-JHLX6360HQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXdPSTpDDgaO0uDCsacrLgAA6apI8ZgZg',
    appId: '1:1054794976066:android:f86d2a8e710621318e96db',
    messagingSenderId: '1054794976066',
    projectId: 'splitexpence-7db38',
    storageBucket: 'splitexpence-7db38.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwJi65_xFbiYn7K-zDamVfaPKJt4J6AAo',
    appId: '1:1054794976066:ios:d738d8f07da8cf8f8e96db',
    messagingSenderId: '1054794976066',
    projectId: 'splitexpence-7db38',
    storageBucket: 'splitexpence-7db38.appspot.com',
    iosBundleId: 'com.example.splitApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwJi65_xFbiYn7K-zDamVfaPKJt4J6AAo',
    appId: '1:1054794976066:ios:d738d8f07da8cf8f8e96db',
    messagingSenderId: '1054794976066',
    projectId: 'splitexpence-7db38',
    storageBucket: 'splitexpence-7db38.appspot.com',
    iosBundleId: 'com.example.splitApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9msML4EBhI8tDNdKYs9P6d7WnRicAoTw',
    appId: '1:1054794976066:web:d2c6c7322f1cb42c8e96db',
    messagingSenderId: '1054794976066',
    projectId: 'splitexpence-7db38',
    authDomain: 'splitexpence-7db38.firebaseapp.com',
    storageBucket: 'splitexpence-7db38.appspot.com',
    measurementId: 'G-8V8SN3XEX1',
  );
}
