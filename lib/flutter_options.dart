import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web is not configured for this Firebase project.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'iOS is not configured for this Firebase project.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'macOS is not configured for this Firebase project.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'Windows is not configured for this Firebase project.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'Linux is not configured for this Firebase project.',
        );
      default:
        throw UnsupportedError(
          'This platform is not supported.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxJrbFvOQKA1LJWSqKoklVZ0HvIjDkJDg',
    appId: '1:958487597412:android:3ac6827cab4051825d6a71',
    messagingSenderId: '958487597412',
    projectId: 'bavs-app',
    storageBucket: 'bavs-app.firebasestorage.app',
  );
}
