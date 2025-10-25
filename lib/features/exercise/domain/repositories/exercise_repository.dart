import '../entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExercises();
  Future<void> refreshExercisesFromBackend();
}
