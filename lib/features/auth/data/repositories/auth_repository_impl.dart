import '../../../../core/entities/user.dart';
import '../../../../core/errors/exception_mapper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local_auth_datasource.dart';
import '../datasources/remote_auth_datasource.dart';
import '../datasources/database_auth_datasource.dart';
import '../models/auth_models.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource remoteDataSource;
  final LocalAuthDataSource localDataSource;
  final DatabaseAuthDataSource databaseDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.databaseDataSource,
  });

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginResponse = await remoteDataSource.login(
        LoginRequest(email: email, password: password),
      );

      await localDataSource.saveToken(loginResponse.accessToken);
      await localDataSource.saveRefreshToken(loginResponse.refreshToken);

      await localDataSource.saveUserInfo(
        id: loginResponse.user.id,
        name: loginResponse.user.name,
        email: loginResponse.user.email,
      );

      await databaseDataSource.upsertUser(loginResponse.user);

      return loginResponse.user.toEntity();
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localDataSource.clearAuthData();
    } catch (e) {
      // ignore errors, logout by UI
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userId = await localDataSource.getUserId();

      if (userId == null) {
        return null;
      }
      
      final localUser = await databaseDataSource.getUserById(userId);

      if (localUser == null) {
        return null;
      }
      
      return localUser.toEntity();
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final isLoggedIn = (await localDataSource.getToken()) != null;
      return isLoggedIn;
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    // TODO: Implementar registro cuando sea necesario
    throw const ServerException(message: 'Registro no implementado aún');
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    // TODO: Implementar recuperación de contraseña cuando sea necesario
    throw const ServerException(message: 'Recuperación de contraseña no implementada aún');
  }

  @override
  void dispose() {
    remoteDataSource.dispose();
    localDataSource.dispose();
  }
}