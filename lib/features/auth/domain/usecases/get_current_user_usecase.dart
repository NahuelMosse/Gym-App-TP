import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/base_interfaces.dart';

class GetCurrentUserUseCase extends BaseUseCase<Either<Failure, User?>, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}