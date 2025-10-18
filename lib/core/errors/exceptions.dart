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


class DatabaseConnectionException extends DomainException {
  const DatabaseConnectionException({
    super.message = 'Failed to connect to database',
    super.code = 500,
  });
}

class DatabaseInitializationException extends DomainException {
  const DatabaseInitializationException({
    super.message = 'Failed to initialize database',
    super.code = 500,
  });
}

class DatabaseMigrationException extends DomainException {
  const DatabaseMigrationException({
    super.message = 'Database migration failed',
    super.code = 500,
  });
}

class DatabaseQueryException extends DomainException {
  const DatabaseQueryException({
    super.message = 'Database query failed',
    super.code = 500,
  });
}

class DatabaseInsertException extends DomainException {
  const DatabaseInsertException({
    super.message = 'Failed to insert data',
    super.code = 500,
  });
}

class DatabaseUpdateException extends DomainException {
  const DatabaseUpdateException({
    super.message = 'Failed to update data',
    super.code = 500,
  });
}

class DatabaseDeleteException extends DomainException {
  const DatabaseDeleteException({
    super.message = 'Failed to delete data',
    super.code = 500,
  });
}

class DatabaseTransactionException extends DomainException {
  const DatabaseTransactionException({
    super.message = 'Database transaction failed',
    super.code = 500,
  });
}

class DatabaseCorruptionException extends DomainException {
  const DatabaseCorruptionException({
    super.message = 'Database corruption detected',
    super.code = 500,
  });
}

class DatabaseLockException extends DomainException {
  const DatabaseLockException({
    super.message = 'Database is locked',
    super.code = 423,
  });
}

class DatabaseConstraintException extends DomainException {
  const DatabaseConstraintException({
    super.message = 'Database constraint violation',
    super.code = 409,
  });
}

class EntityNotFoundException extends DomainException {
  const EntityNotFoundException({
    super.message = 'Entity not found in database',
    super.code = 404,
  });
}

class CancelledException extends DomainException {
  const CancelledException({super.message = 'Request cancelled', super.code});
}

class DatabaseDeletionException extends DomainException {
  const DatabaseDeletionException({required super.message, super.code});
}

class DatabaseSeedingException extends DomainException {
  const DatabaseSeedingException({required super.message, super.code});
}