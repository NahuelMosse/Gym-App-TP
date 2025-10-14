import '../repositories/auth_repository.dart';
import '../../../../core/interfaces/base_interfaces.dart';

class LogoutUseCase extends BaseUseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<void> call(NoParams params) async {
    return await repository.logout();
  }
}