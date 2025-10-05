import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static Future<void> initialize() async {
    if (kDebugMode) {
      await dotenv.load(fileName: ".env");
    } else if (kProfileMode) {
      await dotenv.load(fileName: ".env.qa");
    } else if (kReleaseMode) {
      await dotenv.load(fileName: ".env.prod");
    } else {
      await dotenv.load(fileName: ".env");
    }
  }

  static String get apiUrl {
    return dotenv.get('API_URL', fallback: 'http://localhost:8080/api/v1');
  }

  static Duration get httpTimeout {
    final timeoutSeconds = int.tryParse(dotenv.get('HTTP_TIMEOUT', fallback: '30')) ?? 30;
    return Duration(seconds: timeoutSeconds);
  }
}