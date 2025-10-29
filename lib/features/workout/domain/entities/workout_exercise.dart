import '../../../exercise/domain/entities/exercise.dart';
import 'workout.dart';

class WorkoutExercise {
  final String id;
  final String metodo;
  final int order;
  final int exerciseId;
  final int workoutId;
  final DateTime updatedAt;
  final DateTime createdAt;

  final Exercise? exercise;
  final Workout? workout;

  WorkoutExercise({
    required this.id,
    required this.metodo,
    required this.order,
    required this.exerciseId,
    required this.workoutId,
    required this.updatedAt,
    required this.createdAt,
    this.exercise,
    this.workout,
  });
}
