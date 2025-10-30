import 'package:get_it/get_it.dart';
import '../exercise/presentation/state/exercise_bloc.dart';
import 'data/datasources/database_exercise_datasource.dart';
import 'data/datasources/remote_exercise_datasource.dart';
import 'data/repository/exercise_repository_impl.dart';
import 'domain/repositories/exercise_repository.dart';
import 'domain/usecases/get_exercises_usecase.dart';
import '../../core/database/app_database.dart';

class ExerciseInjection {
  static void init(GetIt serviceLocator) {
    // Data Sources
    serviceLocator.registerLazySingleton<RemoteExerciseDataSource>(
      () => RemoteExerciseDataSourceImpl(dio: serviceLocator()),
    );

    serviceLocator.registerLazySingleton<DatabaseExerciseDataSource>(
      () => DatabaseExerciseDataSourceImpl(
        database: serviceLocator<AppDatabase>(),
      ),
    );

    // Repository
    serviceLocator.registerLazySingleton<ExerciseRepository>(
      () => ExerciseRepositoryImpl(
        databaseDataSource: serviceLocator<DatabaseExerciseDataSource>(),
        remoteDataSource: serviceLocator<RemoteExerciseDataSource>(),
      ),
    );

    // Use Cases
    serviceLocator.registerLazySingleton<GetExercisesUseCase>(
      () => GetExercisesUseCase(serviceLocator<ExerciseRepository>()),
    );

    // BLoC
    serviceLocator.registerFactory<ExerciseBloc>(
      () => ExerciseBloc(
        getExercisesUseCase: serviceLocator<GetExercisesUseCase>(),
      ),
    );
  }
}
