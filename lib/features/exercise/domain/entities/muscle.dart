import 'exercise_muscle.dart';

class Muscle {
  final String id;
  final String name;
  final DateTime updatedAt;
  final DateTime createdAt;

  final List<ExerciseMuscle>? exerciseMuscles;

  Muscle({
    required this.id,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    this.exerciseMuscles,
  });
}
