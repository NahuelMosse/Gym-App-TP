import 'package:get_it/get_it.dart';
import 'data/datasources/database_workout_datasource.dart';
import 'data/repository/workout_repository_impl.dart';
import 'domain/repositories/workout_repository.dart';
import '../../core/database/app_database.dart';
import 'domain/usecases/get_workouts_usecase.dart';
import 'presentation/state/workout_bloc.dart';

class WorkoutInjection {
  static void init(GetIt serviceLocator) {
    // Data Sources
    serviceLocator.registerLazySingleton<DatabaseWorkoutDataSource>(
      () => DatabaseWorkoutDataSourceImpl(
        database: serviceLocator<AppDatabase>(),
      ),
    );

    // Repository
    serviceLocator.registerLazySingleton<WorkoutRepository>(
      () => WorkoutRepositoryImpl(
        databaseDataSource: serviceLocator<DatabaseWorkoutDataSource>(),
      ),
    );

    // Use Cases
    serviceLocator.registerLazySingleton<GetWorkoutsUseCase>(
      () => GetWorkoutsUseCase(serviceLocator<WorkoutRepository>()),
    );

    // BLoC
    serviceLocator.registerFactory<WorkoutBloc>(
      () => WorkoutBloc(
        getWorkoutsUseCase: serviceLocator<GetWorkoutsUseCase>(),
      ),
    );
  }
}
