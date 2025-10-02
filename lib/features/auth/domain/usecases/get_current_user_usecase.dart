import '../repositories/auth_repository.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/interfaces/base_interfaces.dart';

class GetCurrentUserUseCase extends BaseUseCase<User?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<User?> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}