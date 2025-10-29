import '../../data/models/workout_model.dart';
import '../entities/workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> getWorkouts();
  Future<void> createWorkout(WorkoutModel workout);
}
