import '../../../../core/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
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
    final loginResponse = await remoteDataSource.login(
      LoginRequest(email: email, password: password)
    );
    
    await localDataSource.saveToken(loginResponse.accessToken);
    await localDataSource.saveRefreshToken(loginResponse.refreshToken);
    
    final userModel = loginResponse.user;
    await localDataSource.saveUser(userModel);
    
    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearAuthData();
  }

  @override
  Future<User?> getCurrentUser() async {
    final localUser = await localDataSource.getUser();
    return localUser?.toEntity();
  }

  @override
  void dispose() {
    remoteDataSource.dispose();
    localDataSource.dispose();
  }
}