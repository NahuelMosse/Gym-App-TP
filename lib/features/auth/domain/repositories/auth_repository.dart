import '../../../../core/entities/user.dart';
import '../../../../core/interfaces/base_interfaces.dart';

abstract class AuthRepository extends BaseRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();
}