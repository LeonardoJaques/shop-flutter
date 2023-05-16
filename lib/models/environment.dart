import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.prod';
    }
    return '.env.dev';
  }

  static String get FIREBASEAPI {
    return dotenv.env['FIREBASE_URL'] ?? 'FIREBASE_URL not found';
  }
}
