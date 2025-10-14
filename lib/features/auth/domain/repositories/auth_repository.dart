import '../../../../core/entities/user.dart';
import '../../../../core/interfaces/base_interfaces.dart';

/// AuthRepository now uses exceptions for error handling according to the
/// project's domain-exception strategy. Methods return plain values and
/// throw DomainException subclasses on error.
abstract class AuthRepository extends BaseRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<bool> isLoggedIn();

  Future<User> register({
    required String email,
    required String password,
    required String name,
  });

  Future<void> forgotPassword({
    required String email,
  });
}