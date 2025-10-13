import 'package:dartz/dartz.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/auth_repository.dart';
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
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginResponse = await remoteDataSource.login(
        LoginRequest(email: email, password: password)
      );
      
      // Guardar tokens y usuario localmente
      await localDataSource.saveToken(loginResponse.token);
      await localDataSource.saveRefreshToken(loginResponse.refreshToken);
      
      // Convertir y guardar el usuario
      final userModel = UserModel.fromJson(loginResponse.user);
      await localDataSource.saveUser(userModel);
      
      // Retornar la entidad User
      return Right(userModel.toEntity());
      
    } on Exception catch (e) {
      // Mapear diferentes tipos de errores
      if (e.toString().contains('Credenciales incorrectas')) {
        return const Left(AuthFailure(message: 'Email o contraseña incorrectos'));
      } else if (e.toString().contains('conexión') || e.toString().contains('Timeout')) {
        return const Left(NetworkFailure(message: 'Error de conexión. Verifica tu internet.'));
      } else if (e.toString().contains('servidor')) {
        return const Left(ServerFailure(message: 'Error del servidor. Intenta más tarde.'));
      } else {
        return Left(AuthFailure(message: 'Error inesperado: ${e.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Intentar cerrar sesión en el servidor
      await remoteDataSource.logout();
      
      // Limpiar datos locales
      await localDataSource.clearAuthData();
      
      return const Right(null);
      
    } on Exception catch (e) {
      // Aunque falle el logout remoto, limpiamos datos locales
      await localDataSource.clearAuthData();
      
      if (e.toString().contains('conexión')) {
        // Si no hay conexión, igual consideramos exitoso el logout local
        return const Right(null);
      } else {
        return Left(AuthFailure(message: 'Error al cerrar sesión: ${e.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      // Primero intentar obtener usuario local
      final localUser = await localDataSource.getUser();
      
      if (localUser != null) {
        return Right(localUser.toEntity());
      }
      
      // Si no hay usuario local, verificar si hay token
      final isLoggedIn = await localDataSource.isLoggedIn();
      if (!isLoggedIn) {
        return const Right(null);
      }
      
      // Intentar obtener usuario del servidor
      final remoteUser = await remoteDataSource.getCurrentUser();
      await localDataSource.saveUser(remoteUser);
      
      return Right(remoteUser.toEntity());
      
    } on Exception catch (e) {
      if (e.toString().contains('401')) {
        // Token expirado, limpiar datos locales
        await localDataSource.clearAuthData();
        return const Right(null);
      } else {
        return Left(AuthFailure(message: 'Error al obtener usuario: ${e.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final isLoggedIn = await localDataSource.isLoggedIn();
      return Right(isLoggedIn);
    } on Exception catch (e) {
      return Left(CacheFailure(message: 'Error al verificar estado de login: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    // TODO: Implementar registro cuando sea necesario
    return const Left(AuthFailure(message: 'Registro no implementado aún'));
  }

  @override
  Future<Either<Failure, void>> forgotPassword({
    required String email,
  }) async {
    // TODO: Implementar recuperación de contraseña cuando sea necesario
    return const Left(AuthFailure(message: 'Recuperación de contraseña no implementada aún'));
  }

  @override
  void dispose() {
    // Limpiar recursos del repositorio
    remoteDataSource.dispose();
    localDataSource.dispose();
    // No llamamos super.dispose() porque BaseRepository.dispose() está vacío
  }
}