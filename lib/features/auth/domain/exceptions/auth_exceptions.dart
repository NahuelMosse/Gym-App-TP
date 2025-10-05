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

class EmptyEmailException extends AuthException {
  const EmptyEmailException({
    super.message = 'Email is required',
    super.code = 400,
  });
}

class InvalidEmailException extends AuthException {
  const InvalidEmailException({
    super.message = 'Invalid email format',
    super.code = 400,
  });
}

class EmptyPasswordException extends AuthException {
  const EmptyPasswordException({
    super.message = 'Password is required',
    super.code = 400,
  });
}

class ShortPasswordException extends AuthException {
  const ShortPasswordException({
    super.message = 'Password must be at least 6 characters',
    super.code = 400,
  });
}
