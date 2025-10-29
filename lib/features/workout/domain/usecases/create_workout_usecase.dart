import '../../../auth/domain/repositories/auth_repository.dart';
import '../repositories/workout_repository.dart';

class CreateWorkoutUsecase {
  final WorkoutRepository repository;
  final AuthRepository authRepository;

  CreateWorkoutUsecase(this.repository, this.authRepository);

  Future<String> call() async {
    final user = await authRepository.getCurrentUser();

    final workoutId = await repository.createWorkout(
      userId: user!.id,
    );

    return workoutId;
  }
}
