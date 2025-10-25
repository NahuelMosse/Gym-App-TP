import '../repositories/exercise_repository.dart';
import '../entities/exercise.dart';

class GetExercisesUseCase {
  final ExerciseRepository repository;

  GetExercisesUseCase(this.repository);

  Future<List<Exercise>> call() async {
    return await repository.getExercises();
  }
}
