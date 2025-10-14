import '../../../../core/entities/user.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/base_interfaces.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository extends BaseRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User?>> getCurrentUser();

  Future<Either<Failure, bool>> isLoggedIn();

  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, void>> forgotPassword({
    required String email,
  });
}