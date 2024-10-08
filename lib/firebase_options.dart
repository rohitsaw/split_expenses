// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABRLIp077c10dL3n9ojadA2SFLI5g4VpM',
    appId: '1:601173186872:android:65244c9cd69a02123fc9cd',
    messagingSenderId: '601173186872',
    projectId: 'portfolio-rsaw409',
    storageBucket: 'portfolio-rsaw409.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZ1-PnXAwaBtXfyPcUaiEQtCpby-D8gpw',
    appId: '1:601173186872:ios:c93451938058a0593fc9cd',
    messagingSenderId: '601173186872',
    projectId: 'portfolio-rsaw409',
    storageBucket: 'portfolio-rsaw409.appspot.com',
    iosBundleId: 'com.example.splitExpense',
  );
}
