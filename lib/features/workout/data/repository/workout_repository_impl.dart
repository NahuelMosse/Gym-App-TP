import '../../../../core/errors/exception_mapper.dart';
import '../../domain/entities/workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/database_workout_datasource.dart';
import '../models/workout_model.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final DatabaseWorkoutDataSource databaseDataSource;

  WorkoutRepositoryImpl({required this.databaseDataSource});

  @override
  Future<List<Workout>> getWorkouts() async {
    try {
      final workouts = await databaseDataSource.fetchWorkouts();

      return workouts.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<void> createWorkout(WorkoutModel workout) async {
    try {
      await databaseDataSource.insertWorkout(workout);
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }
}
