import '../repositories/auth_repository.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/interfaces/base_interfaces.dart';

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

    if (email.isEmpty) {
      throw const BadRequestException(message: 'Email is required');
    }
    
    if (password.isEmpty) {
      throw const BadRequestException(message: 'Password is required');
    }

    if (!_isValidEmail(email)) {
      throw const BadRequestException(message: 'Email is not valid');
    }

    if (password.length < 6) {
      throw const BadRequestException(message: 'Password must be at least 6 characters');
    }

    return await repository.login(email: email, password: password);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}