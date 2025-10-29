import 'package:drift/drift.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/database/app_database.dart';
import '../models/workout_exercise_model.dart';
import '../models/workout_model.dart';

abstract class DatabaseWorkoutDataSource {
  Future<List<WorkoutModel>> fetchWorkouts();
  Future<void> insertWorkout(WorkoutModel workout);
  Future<void> insertWorkoutExercise(
    List<WorkoutExerciseModel> workoutExercise,
  );
}

class DatabaseWorkoutDataSourceImpl implements DatabaseWorkoutDataSource {
  final AppDatabase database;

  DatabaseWorkoutDataSourceImpl({required this.database});

  @override
  Future<List<WorkoutModel>> fetchWorkouts() async {
    try {
      final workouts = await database.select(database.workout).get();

      return workouts
          .map(
            (e) => WorkoutModel(
              id: e.id,
              name: e.name,
              description: e.description,
              userId: e.userId,
              updatedAt: e.updatedAt,
              createdAt: e.createdAt,
            ),
          )
          .toList();
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to get Workouts from database: $e',
      );
    }
  }

  @override
  Future<void> insertWorkout(WorkoutModel workout) async {
    await database
        .into(database.workout)
        .insert(
          WorkoutCompanion.insert(
            id: workout.id,
            name: workout.name,
            description: workout.description,
            userId: workout.userId,
            updatedAt: Value(workout.updatedAt),
            createdAt: Value(workout.createdAt),
          ),
          mode: InsertMode.insert,
        );
  }

  @override
  Future<void> insertWorkoutExercise(
    List<WorkoutExerciseModel> workoutExercise,
  ) async {
    await database.batch((batch) {
      batch.insertAll(
        database.workoutExercise,
        workoutExercise
            .map(
              (we) => WorkoutExerciseCompanion(
                id: Value(we.id),
                method: Value(we.metodo),
                order: Value(we.order),
                exerciseId: Value(we.exerciseId),
                workoutId: Value(we.workoutId),
                updatedAt: Value(we.updatedAt),
                createdAt: Value(we.createdAt),
              ),
            )
            .toList(),
        mode: InsertMode.insert,
      );
    });
  }
}
