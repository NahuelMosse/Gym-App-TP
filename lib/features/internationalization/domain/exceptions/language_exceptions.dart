import '../../../../core/errors/exceptions.dart';

class LanguageException extends DomainException {
  const LanguageException({required super.message, super.code});
}

class LanguageLoadException extends LanguageException {
  const LanguageLoadException({
    super.message = 'Failed to load language preference',
    super.code,
  });
}

class LanguageSaveException extends LanguageException {
  const LanguageSaveException({
    super.message = 'Failed to save language preference',
    super.code,
  });
}
