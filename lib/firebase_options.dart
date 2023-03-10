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
    apiKey: 'AIzaSyAIKD6W76cd6LQx_EGRAczxLk6x1KpEFtM',
    appId: '1:654882640332:web:70a389aed68cac1bd54d69',
    messagingSenderId: '654882640332',
    projectId: 'ai-creator-suite',
    authDomain: 'ai-creator-suite.firebaseapp.com',
    storageBucket: 'ai-creator-suite.appspot.com',
    measurementId: 'G-00YHLZ51WQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7IyQ4ge20DAL5FvjrgpykzqYgVPNSOIY',
    appId: '1:654882640332:android:7ee98a49fed90634d54d69',
    messagingSenderId: '654882640332',
    projectId: 'ai-creator-suite',
    storageBucket: 'ai-creator-suite.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPehmRAo8S5u6J2LYEMTVW0SmpNQjy-48',
    appId: '1:654882640332:ios:f05881c8ce3793e8d54d69',
    messagingSenderId: '654882640332',
    projectId: 'ai-creator-suite',
    storageBucket: 'ai-creator-suite.appspot.com',
    iosClientId: '654882640332-q7vpajpftdk6a1uq4ia2icofeoupqr1u.apps.googleusercontent.com',
    iosBundleId: 'com.example.aiCreator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPehmRAo8S5u6J2LYEMTVW0SmpNQjy-48',
    appId: '1:654882640332:ios:15291a26fbd2dd2ed54d69',
    messagingSenderId: '654882640332',
    projectId: 'ai-creator-suite',
    storageBucket: 'ai-creator-suite.appspot.com',
    iosClientId: '654882640332-7qq15cer055rq2t73rgbj1hlprqeor1q.apps.googleusercontent.com',
    iosBundleId: 'com.example.aiCreator.RunnerTests',
  );
}
