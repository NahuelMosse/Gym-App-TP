import '../../../../core/errors/exceptions.dart';

class AuthErrorHandler {
  static String getErrorMessage(Object exception) {
    if (exception is TimeoutException) {
      return 'Tiempo de espera agotado. Intenta nuevamente.';
    }
    
    if (exception is ConnectionException) {
      return 'Error de conexión. Verifica tu internet.';
    }
    
    if (exception is UnauthorizedException || exception is InvalidCredentialsException) {
      return 'Email o contraseña incorrectos';
    }
    
    if (exception is TokenExpiredException) {
      return 'Sesión expirada. Inicia sesión nuevamente';
    }
    
    if (exception is ForbiddenException) {
      return 'No tienes permisos para realizar esta acción';
    }
    
    if (exception is InternalServerException) {
      return 'Error del servidor. Intenta más tarde.';
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

    return 'Error inesperado. Intenta nuevamente.';
  }
}