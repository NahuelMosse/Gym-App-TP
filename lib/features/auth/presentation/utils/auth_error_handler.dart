import 'package:flutter/material.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../internationalization/generated/translations.dart';
import '../../domain/exceptions/auth_exceptions.dart';

class AuthErrorHandler {
  static String getErrorMessage(Object exception, [BuildContext? context]) {
    final translations = context != null ? Translations.of(context) : null;
    
    // Validation exceptions
    if (exception is EmptyEmailException) {
      return translations?.pleaseEnterEmail ?? 'Please enter your email';
    }
    
    if (exception is InvalidEmailException) {
      return translations?.pleaseEnterValidEmail ?? 'Please enter a valid email';
    }
    
    if (exception is EmptyPasswordException) {
      return translations?.pleaseEnterPassword ?? 'Please enter your password';
    }
    
    if (exception is ShortPasswordException) {
      return translations?.passwordMinLength ?? 'Password must be at least 6 characters';
    }
    
    // Network/Connection exceptions
    if (exception is TimeoutException) {
      return translations?.connectionError ?? 'Connection timeout. Please try again.';
    }
    
    if (exception is ConnectionException || exception is NetworkException) {
      return translations?.connectionError ?? 'Connection error. Check your internet.';
    }
    
    // Auth exceptions
    if (exception is UnauthorizedException || exception is InvalidCredentialsException) {
      return translations?.incorrectCredentials ?? 'Incorrect email or password';
    }
    
    if (exception is TokenExpiredException) {
      return translations?.sessionExpired ?? 'Session expired. Please sign in again';
    }
    
    if (exception is InvalidResponseException) {
      return translations?.invalidServerResponse ?? 'Invalid server response. Please try again.';
    }
    
    if (exception is ParseException) {
      return translations?.invalidServerResponse ?? 'Error processing server data. Please try again.';
    }
    
    if (exception is ForbiddenException) {
      return translations?.noPermission ?? 'You do not have permission to perform this action';
    }
    
    // Server exceptions
    if (exception is InternalServerException) {
      return translations?.serverError ?? 'Server error. Please try again later.';
    }
    
    if (exception is ServerException) {
      return translations?.serverError ?? exception.message;
    }
    
    // Storage exceptions
    if (exception is CacheException) {
      return exception.message;
    }
    
    if (exception is StorageException) {
      return exception.message;
    }

    return translations?.unexpectedError ?? 'Unexpected error. Please try again.';
  }
}