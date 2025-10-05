import '../repositories/auth_repository.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/interfaces/base_interfaces.dart';
import '../validators/auth_validators.dart';

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

    AuthValidators.validateEmail(email);
    AuthValidators.validatePassword(password);

    return await repository.login(email: email, password: password);
  }
}