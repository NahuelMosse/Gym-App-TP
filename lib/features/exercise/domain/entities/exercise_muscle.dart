import 'exercise.dart';
import 'muscle.dart';

class ExerciseMuscle {
  final String id;
  final String muscleId;
  final String exerciseId;
  final DateTime updatedAt;
  final DateTime createdAt;

  final Exercise? exercise;
  final Muscle? muscle;

  ExerciseMuscle({
    required this.id,
    required this.muscleId,
    required this.exerciseId,
    required this.updatedAt,
    required this.createdAt,
    this.exercise,
    this.muscle,
  });
}
