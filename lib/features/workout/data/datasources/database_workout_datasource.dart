import '../../../../core/errors/exceptions.dart';
import '../../../../core/database/app_database.dart';
import '../models/workout_model.dart';

abstract class DatabaseWorkoutDataSource {
  Future<List<WorkoutModel>> fetchWorkouts();
}

class DatabaseWorkoutDataSourceImpl implements DatabaseWorkoutDataSource {
  final AppDatabase database;

  DatabaseWorkoutDataSourceImpl({required this.database});

  @override
  Future<List<WorkoutModel>> fetchWorkouts() async {
    try {
      final workouts = await database.select(database.workout).get();

      return workouts.map((e) => WorkoutModel(
        id: e.id,
        name: e.name,
        description: e.description,
        userId: e.userId,
        updatedAt: e.updatedAt,
        createdAt: e.createdAt,
      )).toList();
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to get Workouts from database: $e',
      );
    }
  }
}
