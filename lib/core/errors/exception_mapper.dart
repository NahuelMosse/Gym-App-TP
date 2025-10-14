import 'dart:io';
import 'package:dio/dio.dart';
import 'exceptions.dart';

/// Maps any exception to domain exceptions following Clean Architecture principles.
DomainException mapExceptionToDomain(Object e) {
  if (e is DomainException) return e;

  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            return const BadRequestException();
          case 401:
            return const UnauthorizedException();
          case 403:
            return const ForbiddenException();
          case 404:
            return const NotFoundException();
          case 500:
            return const InternalServerException();
          default:
            return ServerException(message: 'Error HTTP: $statusCode', code: statusCode);
        }
      case DioExceptionType.cancel:
        return const CancelledException();
      case DioExceptionType.connectionError:
        return const ConnectionException();
      default:
        return NetworkException(message: 'Error de red: ${e.message}');
    }
  }

  if (e is SocketException) return const ConnectionException();
  if (e is TimeoutException) return const TimeoutException();

  if (e is Exception) {
    final s = e.toString().toLowerCase();
    if (s.contains('conexión') || s.contains('timeout') || s.contains('socket') || s.contains('connection')) {
      return const ConnectionException();
    }
    if (s.contains('credenciales') || s.contains('unauthorized') || s.contains('401') || s.contains('invalid token')) {
      return const UnauthorizedException();
    }
    if (s.contains('servidor') || s.contains('500') || s.contains('error http') || s.contains('internal server error')) {
      return const InternalServerException();
    }
  }

  return const ServerException(message: 'Error inesperado');
}

/// Maps domain exceptions to user-friendly messages
String mapExceptionToMessage(DomainException e) {
  if (e is NetworkException) return e.message;
  if (e is TimeoutException) return 'Tiempo de espera agotado. Intenta nuevamente.';
  if (e is ConnectionException) return 'Error de conexión. Verifica tu internet.';
  if (e is ServerException) return e.message;
  if (e is BadRequestException) return 'Datos inválidos enviados';
  if (e is UnauthorizedException || e is InvalidResponseException) return 'Email o contraseña incorrectos';
  if (e is ForbiddenException) return 'No tienes permisos para realizar esta acción';
  if (e is NotFoundException) return 'Recurso no encontrado';
  if (e is InternalServerException) return 'Error del servidor. Intenta más tarde.';
  if (e is CancelledException) return 'Operación cancelada';
  if (e is CacheException || e is StorageException) return e.message;
  return 'Error inesperado';
}
