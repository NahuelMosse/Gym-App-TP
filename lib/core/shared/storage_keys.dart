// ignore_for_file: dangling_library_doc_comments

/// 🗃️ CENTRALIZED STORAGE KEYS
/// 
/// This file contains ALL keys used for data persistence in the app.
/// 
/// 🔒 SecureStorageKeys    → FlutterSecureStorage (encrypted, for sensitive data)
/// 📄 SharedPreferencesKeys → SharedPreferences (plain text, for app settings)
/// 
/// ⚠️  NEVER mix these! Use secure storage for tokens/passwords, 
///     shared preferences for themes/settings only.


/// 🔒 SECURE STORAGE KEYS (FlutterSecureStorage)
/// 
/// These keys are for SENSITIVE data that gets encrypted by the OS:
/// - iOS: stored in Keychain (hardware-backed security)
/// - Android: stored in EncryptedSharedPreferences + Android Keystore
/// 
/// Usage: await secureStorage.write(key: SecureStorageKeys.accessToken, value: token)
class SecureStorageKeys {
  // Private constructor to prevent instantiation
  SecureStorageKeys._();

  /// JWT access token for API authentication
  /// 🔑 Secure Storage Key: 'access_token'
  static const String accessToken = 'access_token';
  
  /// JWT refresh token for renewing expired access tokens
  /// 🔑 Secure Storage Key: 'refresh_token'
  static const String refreshToken = 'refresh_token';

  static List<String> get allValues => [
    accessToken,
    refreshToken,
  ];
  
  static Future<void> clearAll(dynamic secureStorage) async {
    for (final key in allValues) {
      await secureStorage.delete(key: key);
    }
  }
}


/// 📄 SHARED PREFERENCES KEYS (SharedPreferences)
/// 
/// These keys are for NON-SENSITIVE data stored in plain text:
/// - App settings, preferences, flags
/// - User data that's not security-critical
/// - Configuration that's okay to be readable
/// 
/// Usage: await sharedPreferences.setString(SharedPreferencesKeys.userData, json)
class SharedPreferencesKeys {
  // Private constructor to prevent instantiation
  SharedPreferencesKeys._();

  /// User profile information stored as JSON (id, email, name, timestamps)
  /// 📄 Shared Preferences Key: 'user_data'
  static const String userData = 'user_data';
  
  /// App theme setting (light/dark/system)
  /// 📄 Shared Preferences Key: 'theme_mode'
  static const String themeMode = 'theme_mode';
  
  /// User's preferred language/locale (en, es, etc.)
  /// 📄 Shared Preferences Key: 'locale'
  static const String locale = 'locale';
  
  /// Flag indicating if user completed onboarding flow
  /// 📄 Shared Preferences Key: 'onboarding_completed'
  static const String onboardingCompleted = 'onboarding_completed';
  
  /// Timestamp of last successful data synchronization
  /// 📄 Shared Preferences Key: 'last_sync'
  static const String lastSync = 'last_sync';

  static List<String> get allValues => [
    userData,
    themeMode,
    locale,
    onboardingCompleted,
    lastSync,
  ];
  
  static Future<void> clearAll(dynamic sharedPreferences) async {
    for (final key in allValues) {
      await sharedPreferences.remove(key);
    }
  }
}