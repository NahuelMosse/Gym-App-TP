import 'package:email_validator/email_validator.dart';
import '../exceptions/auth_exceptions.dart';

class AuthValidators {
  AuthValidators._();

  static void validateEmailNotEmpty(String email) {
    if (email.isEmpty) {
      throw const EmptyEmailException();
    }
  }

  static void validateEmailFormat(String email) {
    if (!EmailValidator.validate(email)) {
      throw const InvalidEmailException();
    }
  }

  static void validatePasswordNotEmpty(String password) {
    if (password.isEmpty) {
      throw const EmptyPasswordException();
    }
  }

  static void validatePasswordLength(String password, {int minLength = 6}) {
    if (password.length < minLength) {
      throw const ShortPasswordException();
    }
  }

  static void validateEmail(String email) {
    validateEmailNotEmpty(email);
    validateEmailFormat(email);
  }

  static void validatePassword(String password, {int minLength = 6}) {
    validatePasswordNotEmpty(password);
    validatePasswordLength(password, minLength: minLength);
  }
}
