import 'package:get_it/get_it.dart';
import 'data/datasources/language_local_data_source.dart';
import 'data/repositories/language_repository_impl.dart';
import 'domain/repositories/language_repository.dart';
import 'domain/usecases/get_current_locale_usecase.dart';
import 'domain/usecases/change_locale_usecase.dart';
import 'presentation/state/language_bloc.dart';

class InternationalizationInjection {
  static void init(GetIt serviceLocator) {
    // Data sources
    serviceLocator.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSource(
        sharedPreferences: serviceLocator(),
      ),
    );

    // Repositories
    serviceLocator.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl(
        localDataSource: serviceLocator<LanguageLocalDataSource>(),
      ),
    );

    // Use cases
    serviceLocator.registerLazySingleton<GetCurrentLocaleUseCase>(
      () => GetCurrentLocaleUseCase(
        repository: serviceLocator<LanguageRepository>(),
      ),
    );

    serviceLocator.registerLazySingleton<ChangeLocaleUseCase>(
      () => ChangeLocaleUseCase(
        repository: serviceLocator<LanguageRepository>(),
      ),
    );

    // Blocs
    serviceLocator.registerFactory<LanguageBloc>(
      () => LanguageBloc(
        getCurrentLocaleUseCase: serviceLocator<GetCurrentLocaleUseCase>(),
        changeLocaleUseCase: serviceLocator<ChangeLocaleUseCase>(),
      ),
    );
  }
}
