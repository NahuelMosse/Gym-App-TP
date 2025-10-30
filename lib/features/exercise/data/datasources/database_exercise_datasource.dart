import '../../../../core/errors/exceptions.dart';
import '../../../../core/database/app_database.dart';
import '../models/exercise_model.dart';
import '../models/exercise_muscle_model.dart';
import '../models/muscle_model.dart';
import 'package:drift/drift.dart';

abstract class DatabaseExerciseDataSource {
  Future<List<ExerciseModel>> fetchExercises();
  Future<void> saveExercises(List<ExerciseModel> exercises); // Added method
  Future<void> saveExerciseMuscle(List<ExerciseMuscleModel> exerciseMuscles);
  Future<void> saveMuscle(List<MuscleModel> muscles);
}

class DatabaseExerciseDataSourceImpl implements DatabaseExerciseDataSource {
  final AppDatabase database;

  DatabaseExerciseDataSourceImpl({required this.database});

  @override
  Future<List<ExerciseModel>> fetchExercises() async {
    try {
      final exercises = await database.select(database.exercise).join([
        leftOuterJoin(
          database.exerciseMuscle,
          database.exerciseMuscle.exerciseId.equalsExp(database.exercise.id),
        ),
        leftOuterJoin(
          database.muscle,
          database.exerciseMuscle.muscleId.equalsExp(database.muscle.id),
        ),
      ]).get();

      final exerciseMap = <String, List<ExerciseMuscleModel>>{};
      final uniqueExercises = <String, ExerciseModel>{};

      for (final row in exercises) {
        final exercise = row.readTable(database.exercise);
        final exerciseMuscle = row.readTableOrNull(database.exerciseMuscle);
        final muscle = row.readTableOrNull(database.muscle);

        if (exerciseMuscle != null && muscle != null) {
          final exerciseMuscleModel = ExerciseMuscleModel(
            id: exerciseMuscle.id,
            muscleId: exerciseMuscle.muscleId,
            exerciseId: exerciseMuscle.exerciseId,
            updatedAt: exerciseMuscle.updatedAt,
            createdAt: exerciseMuscle.createdAt,
            muscle: MuscleModel(
              id: muscle.id,
              name: muscle.name,
              updatedAt: muscle.updatedAt,
              createdAt: muscle.createdAt,
            ),
          );

          exerciseMap
              .putIfAbsent(exercise.id, () => [])
              .add(exerciseMuscleModel);
        }

        uniqueExercises.putIfAbsent(
          exercise.id,
          () => ExerciseModel(
            id: exercise.id,
            name: exercise.name,
            description: exercise.description,
            creatorUserId: exercise.creatorUserId,
            public: exercise.public,
            updatedAt: exercise.updatedAt,
            createdAt: exercise.createdAt,
            exerciseMuscles: exerciseMap[exercise.id] ?? [],
          ),
        );
      }

      return uniqueExercises.values.toList();
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to get Exercises from database: $e',
      );
    }
  }

  @override
  Future<void> saveExercises(List<ExerciseModel> exercises) async {
    try {
      await database.batch((batch) {
        batch.insertAll(
          database.exercise,
          exercises
              .map(
                (e) => ExerciseCompanion(
                  id: Value(e.id),
                  name: Value(e.name),
                  description: Value(e.description),
                  creatorUserId: Value(e.creatorUserId),
                  public: Value(e.public),
                  updatedAt: Value(e.updatedAt),
                  createdAt: Value(e.createdAt),
                ),
              )
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to save Exercises to database: $e',
      );
    }
  }

  @override
  Future<void> saveExerciseMuscle(
    List<ExerciseMuscleModel> exerciseMuscles,
  ) async {
    try {
      await database.batch((batch) {
        batch.insertAll(
          database.exerciseMuscle,
          exerciseMuscles
              .map(
                (em) => ExerciseMuscleCompanion(
                  id: Value(em.id),
                  muscleId: Value(em.muscleId),
                  exerciseId: Value(em.exerciseId),
                  updatedAt: Value(em.updatedAt),
                  createdAt: Value(em.createdAt),
                ),
              )
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to save Exercise-Muscle relationships to database: $e',
      );
    }
  }

  @override
  Future<void> saveMuscle(List<MuscleModel> muscles) async {
    try {
      await database.batch((batch) {
        batch.insertAll(
          database.muscle,
          muscles
              .map(
                (m) => MuscleCompanion(
                  id: Value(m.id),
                  name: Value(m.name),
                  updatedAt: Value(m.updatedAt),
                  createdAt: Value(m.createdAt),
                ),
              )
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to save Muscles to database: $e',
      );
    }
  }
}
