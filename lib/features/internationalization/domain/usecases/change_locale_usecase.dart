import 'package:flutter/material.dart';
import '../exceptions/language_exceptions.dart';
import '../repositories/language_repository.dart';

class ChangeLocaleUseCase {
  final LanguageRepository repository;

  ChangeLocaleUseCase({required this.repository});

  Future<void> call(Locale locale) async {
    try {
      await repository.saveLocale(locale);
    } catch (e) {
      throw LanguageSaveException(message: e.toString());
    }
  }
}
