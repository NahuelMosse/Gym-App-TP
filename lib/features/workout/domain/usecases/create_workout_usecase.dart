import '../../data/models/workout_model.dart';
import '../repositories/workout_repository.dart';

class CreateWorkoutUsecase {
  final WorkoutRepository repository;

  CreateWorkoutUsecase(this.repository);

  Future<void> call(WorkoutModel workout) async {
    await repository.createWorkout(workout);
  }
}
