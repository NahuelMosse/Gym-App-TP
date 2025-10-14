import '../../../../core/entities/user.dart';
import '../../../../core/errors/exception_mapper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import '../datasources/local_auth_datasource.dart';
import '../datasources/remote_auth_datasource.dart';
import '../models/auth_models.dart';
import '../models/user_model.dart';

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

      // Guardar tokens y usuario localmente
      await localDataSource.saveToken(loginResponse.token);
      await localDataSource.saveRefreshToken(loginResponse.refreshToken);

      // Convertir y guardar el usuario
      final userModel = UserModel.fromJson(loginResponse.user);
      await localDataSource.saveUser(userModel);

      // Retornar la entidad User
      return userModel.toEntity();
    } catch (e) {
      // Mapear cualquier excepción a DomainException y relanzar
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Intentar cerrar sesión en el servidor
      await remoteDataSource.logout();

      // Limpiar datos locales
      await localDataSource.clearAuthData();
    } catch (e) {
      // Aunque falle el logout remoto, limpiamos datos locales y relanzamos como DomainException
      await localDataSource.clearAuthData();
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      // Primero intentar obtener usuario local
      final localUser = await localDataSource.getUser();

      if (localUser != null) {
        return localUser.toEntity();
      }

      // Si no hay usuario local, verificar si hay token
      final token = await localDataSource.getToken();
      if (token == null) {
        return null;
      }

      // Intentar obtener usuario del servidor
      final remoteUser = await remoteDataSource.getCurrentUser();
      await localDataSource.saveUser(remoteUser);

      return remoteUser.toEntity();
    } catch (e) {
      final domainEx = mapExceptionToDomain(e);
      if (domainEx is UnauthorizedException || domainEx is TokenExpiredException) {
        // Token inválido/expirado → limpiar datos locales y devolver null
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
    // Limpiar recursos del repositorio
    remoteDataSource.dispose();
    localDataSource.dispose();
    // No llamamos super.dispose() porque BaseRepository.dispose() está vacío
  }
}