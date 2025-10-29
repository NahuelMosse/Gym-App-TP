import '../../../../core/errors/exception_mapper.dart';
import '../../domain/entities/workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/database_workout_datasource.dart';

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
  Future<String> createWorkout({ required String userId }) async {
    try {
      final workoutId = await databaseDataSource.insertWorkout(
        name: 'Workout',
        userId: userId,
      );

      return workoutId;
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }
}
