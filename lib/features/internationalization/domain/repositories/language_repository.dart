import 'package:flutter/material.dart';

abstract class LanguageRepository {
  Future<Locale?> getSavedLocale();

  Future<void> saveLocale(Locale locale);

  Future<void> clearSavedLocale();
}
