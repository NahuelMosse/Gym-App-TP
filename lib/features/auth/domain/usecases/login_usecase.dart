import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/base_interfaces.dart';

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}

class LoginUseCase extends BaseUseCase<Either<Failure, User>, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    final email = params.email;
    final password = params.password;
    // Validaciones básicas
    if (email.isEmpty) {
      return const Left(ValidationFailure(message: 'El email es requerido'));
    }
    
    if (password.isEmpty) {
      return const Left(ValidationFailure(message: 'La contraseña es requerida'));
    }

    if (!_isValidEmail(email)) {
      return const Left(ValidationFailure(message: 'El email no es válido'));
    }

    if (password.length < 6) {
      return const Left(ValidationFailure(message: 'La contraseña debe tener al menos 6 caracteres'));
    }

    return await repository.login(email: email, password: password);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}