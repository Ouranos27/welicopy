// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFwJcXOsndj2vapj88oaU8miHTIU4u4yk',
    appId: '1:537383620326:android:e3a34b4eb96b821360b527',
    messagingSenderId: '537383620326',
    projectId: 'weli-prod',
    storageBucket: 'weli-prod.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsc5zP4Hf3JtACWhjYzPnwFyr5adZv3Ko',
    appId: '1:537383620326:ios:390b8cab513591fc60b527',
    messagingSenderId: '537383620326',
    projectId: 'weli-prod',
    storageBucket: 'weli-prod.appspot.com',
    iosClientId: '537383620326-vf7frj8iko8oukvprnit71i7sgns0cm5.apps.googleusercontent.com',
    iosBundleId: 'com.florentalbero.weli',
  );
}
