import '../entities/workout.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutsUseCase {
  final WorkoutRepository repository;

  GetWorkoutsUseCase(this.repository);

  Future<List<Workout>> call() async {
    return await repository.getWorkouts();
  }
}
