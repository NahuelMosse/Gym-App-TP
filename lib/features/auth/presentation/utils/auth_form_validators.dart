import 'package:flutter/material.dart';
import '../../../internationalization/generated/translations.dart';
import '../../domain/validators/auth_validators.dart';
import '../../domain/exceptions/auth_exceptions.dart';

class AuthFormValidators {
  AuthFormValidators._();

  static String? Function(String?) emailValidator(BuildContext context) {
    return (value) {
      if (value == null) return null;
      
      final translations = Translations.of(context);
      
      try {
        AuthValidators.validateEmail(value);
        return null;
      } catch (e) {
        return _getValidationMessage(e, translations);
      }
    };
  }

  static String? Function(String?) passwordValidator(BuildContext context, {int minLength = 6}) {
    return (value) {
      if (value == null) return null;
      
      final translations = Translations.of(context);
      
      try {
        AuthValidators.validatePassword(value, minLength: minLength);
        return null;
      } catch (e) {
        return _getValidationMessage(e, translations);
      }
    };
  }

  static String? _getValidationMessage(Object exception, Translations translations) {
    if (exception is EmptyEmailException) {
      return translations.pleaseEnterEmail;
    }
    if (exception is InvalidEmailException) {
      return translations.pleaseEnterValidEmail;
    }
    if (exception is EmptyPasswordException) {
      return translations.pleaseEnterPassword;
    }
    if (exception is ShortPasswordException) {
      return translations.passwordMinLength;
    }
    
    return translations.unexpectedError;
  }
}
