import '../../../../core/entities/user.dart';
import '../../../../core/errors/exception_mapper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import '../datasources/local_auth_datasource.dart';
import '../datasources/remote_auth_datasource.dart';
import '../models/auth_models.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource remoteDataSource;
  final LocalAuthDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
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

      await localDataSource.saveUser(loginResponse.user);

      return loginResponse.user.toEntity();
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();

      await localDataSource.clearAuthData();
    } catch (e) {
      await localDataSource.clearAuthData();
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final localUser = await localDataSource.getUser();

      if (localUser != null) {
        return localUser.toEntity();
      }

      final token = await localDataSource.getToken();
      if (token == null) {
        return null;
      }

      final remoteUser = await remoteDataSource.getCurrentUser();
      await localDataSource.saveUser(remoteUser);

      return remoteUser.toEntity();
    } catch (e) {
      final domainEx = mapExceptionToDomain(e);
      if (domainEx is UnauthorizedException || domainEx is TokenExpiredException) {
        await localDataSource.clearAuthData();
        return null;
      }
      throw domainEx;
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