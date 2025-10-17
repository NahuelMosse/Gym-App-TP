import 'package:equatable/equatable.dart';
abstract class DomainException extends Equatable implements Exception {
  final String message;
  final int? code;

  const DomainException({required this.message, this.code});

  @override
  String toString() => 'DomainException(message: $message, code: $code)';

  // Equatable
  @override
  List<Object?> get props => [message, code];

  // Equatable
  @override
  bool get stringify => true;
}

class NetworkException extends DomainException {
  const NetworkException({required super.message, super.code});
}

class TimeoutException extends DomainException {
  const TimeoutException({super.message = 'Request timeout', super.code});
}

class ConnectionException extends DomainException {
  const ConnectionException({super.message = 'Connection error', super.code});
}

class ServerException extends DomainException {
  const ServerException({required super.message, super.code});
}

class BadRequestException extends DomainException {
  const BadRequestException({super.message = 'Bad request', super.code = 400});
}

class UnauthorizedException extends DomainException {
  const UnauthorizedException({super.message = 'Unauthorized', super.code = 401});
}

class ForbiddenException extends DomainException {
  const ForbiddenException({super.message = 'Forbidden', super.code = 403});
}

class NotFoundException extends DomainException {
  const NotFoundException({super.message = 'Not found', super.code = 404});
}

class InternalServerException extends DomainException {
  const InternalServerException({super.message = 'Internal server error', super.code = 500});
}

class InvalidResponseException extends DomainException {
  const InvalidResponseException({
    super.message = 'Invalid server response',
    super.code = 500,
  });
}

class ParseException extends DomainException {
  const ParseException({super.message = 'Failed to parse response', super.code});
}

class CacheException extends DomainException {
  const CacheException({required super.message, super.code});
}

class StorageException extends DomainException {
  const StorageException({required super.message, super.code});
}

class CancelledException extends DomainException {
  const CancelledException({super.message = 'Request cancelled', super.code});
}