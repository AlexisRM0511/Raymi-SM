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
    apiKey: 'AIzaSyAcVuuACFuWIaU80S5r0bmd-JIxHT2yQrA',
    appId: '1:886008803985:web:af74d14c35d80ad5f70530',
    messagingSenderId: '886008803985',
    projectId: 'raymi-sm',
    authDomain: 'raymi-sm.firebaseapp.com',
    storageBucket: 'raymi-sm.appspot.com',
    measurementId: 'G-12GECC023Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYkuQdDbnPDVyYtpCP0D9Rm4fbN5yZbHg',
    appId: '1:886008803985:android:8355373cce41dacef70530',
    messagingSenderId: '886008803985',
    projectId: 'raymi-sm',
    storageBucket: 'raymi-sm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDl5A2iGxHv-JVPkLRmSs6g0kwdAf39c8M',
    appId: '1:886008803985:ios:25e1cf6a9c515f38f70530',
    messagingSenderId: '886008803985',
    projectId: 'raymi-sm',
    storageBucket: 'raymi-sm.appspot.com',
    iosClientId: '886008803985-a8qu2ofde20tu94hhs0akf6i8diagosd.apps.googleusercontent.com',
    iosBundleId: 'com.example.limachayapp',
  );
}
