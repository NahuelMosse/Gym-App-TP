import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../generated/translations.dart';
import '../exceptions/language_exceptions.dart';
import '../repositories/language_repository.dart';

/// Use case to get the current locale for the app
/// 
/// Priority order:
/// 1. Saved locale from storage (user preference)
/// 2. Device locale if supported
/// 3. null (fallback to default)
class GetCurrentLocaleUseCase {
  final LanguageRepository repository;

  GetCurrentLocaleUseCase({required this.repository});

  Future<Locale?> call() async {
    try {
      // 1. Check if user has a saved preference
      final savedLocale = await repository.getSavedLocale();
      if (savedLocale != null) {
        return savedLocale;
      }

      // 2. Try to use device locale if supported
      final deviceLocale = ui.PlatformDispatcher.instance.locale;
      final supportedLocale = _findSupportedLocale(deviceLocale);
      
      if (supportedLocale != null) {
        await repository.saveLocale(supportedLocale);
        return supportedLocale;
      }

      // 3. No saved preference and device locale not supported
      return null;
    } catch (e) {
      throw LanguageLoadException(message: e.toString());
    }
  }

  Locale? _findSupportedLocale(Locale deviceLocale) {
    for (final locale in Translations.supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode) {
        return locale;
      }
    }
    return null;
  }
}
