import '../entities/workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> getWorkouts();
}
