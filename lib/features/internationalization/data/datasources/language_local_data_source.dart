import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/shared/storage_keys.dart';

class LanguageLocalDataSource {
  final SharedPreferences sharedPreferences;

  LanguageLocalDataSource({required this.sharedPreferences});

  Future<Locale?> getSavedLocale() async {
    final localeString = sharedPreferences.getString(SharedPreferencesKeys.locale);
    if (localeString == null || localeString.isEmpty) {
      return null;
    }

    final parts = localeString.split('_');
    return parts.length == 2 
        ? Locale(parts[0], parts[1])  // "en_US" → Locale('en', 'US')
        : Locale(parts[0]);           // "en" → Locale('en')
  }

  Future<void> saveLocale(Locale locale) async {
    final localeString = locale.countryCode != null
        ? '${locale.languageCode}_${locale.countryCode}' // Locale('en', 'US') → "en_US"
        : locale.languageCode;                           // Locale('en') → "en"
    await sharedPreferences.setString(SharedPreferencesKeys.locale, localeString);
  }

  Future<void> clearSavedLocale() async {
    await sharedPreferences.remove(SharedPreferencesKeys.locale);
  }
}
