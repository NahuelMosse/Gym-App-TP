import '../repositories/auth_repository.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/interfaces/base_interfaces.dart';
import 'package:email_validator/email_validator.dart';

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}

class LoginUseCase extends BaseUseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<User> call(LoginParams params) async {
    final email = params.email;
    final password = params.password;

    // Validations - throw domain exceptions
    if (email.isEmpty) {
      throw const BadRequestException(message: 'El email es requerido');
    }
    
    if (password.isEmpty) {
      throw const BadRequestException(message: 'La contraseña es requerida');
    }

    if (!EmailValidator.validate(email)) {
      throw const BadRequestException(message: 'El email no es válido');
    }

    if (password.length < 6) {
      throw const BadRequestException(message: 'La contraseña debe tener al menos 6 caracteres');
    }

    return await repository.login(email: email, password: password);
  }
}