import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/get_current_user_usecase.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/datasources/local_auth_datasource.dart';
import '../data/datasources/remote_auth_datasource.dart';
import '../presentation/state/auth_bloc.dart';

class AuthInjection {
  static void init(GetIt serviceLocator) {
    // Data Sources
    serviceLocator.registerLazySingleton<LocalAuthDataSource>(
      () => LocalAuthDataSourceImpl(
        sharedPreferences: serviceLocator<SharedPreferences>(),
        secureStorage: serviceLocator<FlutterSecureStorage>(),
      ),
    );

    serviceLocator.registerLazySingleton<RemoteAuthDataSource>(
      () => RemoteAuthDataSourceImpl(dio: serviceLocator<Dio>()),
    );

    // Repository
    serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator<RemoteAuthDataSource>(),
        localDataSource: serviceLocator<LocalAuthDataSource>(),
      ),
    );

    // Use Cases
    serviceLocator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(serviceLocator<AuthRepository>()));
    serviceLocator.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(serviceLocator<AuthRepository>()));
    serviceLocator.registerLazySingleton<GetCurrentUserUseCase>(() => GetCurrentUserUseCase(serviceLocator<AuthRepository>()));

    // BLoC
    serviceLocator.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: serviceLocator<LoginUseCase>(),
        logoutUseCase: serviceLocator<LogoutUseCase>(),
        getCurrentUserUseCase: serviceLocator<GetCurrentUserUseCase>(),
      ),
    );
  }
}