import '../../../../core/errors/exceptions.dart';

class AuthException extends DomainException {
  const AuthException({required super.message, super.code});
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException({
    super.message = 'Invalid credentials',
    super.code = 401,
  });
}

class TokenExpiredException extends AuthException {
  const TokenExpiredException({
    super.message = 'Token expired',
    super.code = 401,
  });
}
