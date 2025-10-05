import 'package:flutter/material.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../internationalization/generated/translations.dart';
import '../../domain/exceptions/language_exceptions.dart';

class LanguageErrorStateHandler {
  static String getErrorMessage(Object exception, [BuildContext? context]) {
    final translations = context != null ? Translations.of(context) : null;

    if (exception is LanguageLoadException) {
      return translations?.languageLoadFailed ?? 'Failed to load saved language preference';
    }

    if (exception is LanguageSaveException) {
      return translations?.languageSaveFailed ?? 'Failed to save language preference';
    }

    if (exception is StorageException || exception is CacheException) {
      return translations?.unexpectedError ?? exception.toString();
    }

    return translations?.unexpectedError ?? 'Unexpected error. Please try again.';
  }
}
