import '../../../../core/errors/exceptions.dart';

class AuthErrorHandler {
  static String getErrorMessage(Object exception) {
    if (exception is TimeoutException) {
      return 'Tiempo de espera agotado. Intenta nuevamente.';
    }
    
    if (exception is ConnectionException) {
      return 'Connection error. Check your internet.';
    }
    
    if (exception is UnauthorizedException || exception is InvalidCredentialsException) {
      return 'Incorrect email or password';
    }
    
    if (exception is TokenExpiredException) {
      return 'Session expired. Please sign in again';
    }
    
    if (exception is ForbiddenException) {
      return 'You do not have permission to perform this action';
    }
    
    if (exception is InternalServerException) {
      return 'Server error. Please try again later.';
    }
    
    if (exception is ServerException) {
      return exception.message;
    }
    
    if (exception is NetworkException) {
      return exception.message;
    }
    
    if (exception is CacheException) {
      return exception.message;
    }
    
    if (exception is StorageException) {
      return exception.message;
    }

    return 'Unexpected error. Please try again.';
  }
}