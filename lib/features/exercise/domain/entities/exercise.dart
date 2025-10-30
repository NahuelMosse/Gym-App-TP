import 'exercise_muscle.dart';

class Exercise {
  final String id;
  final String name;
  final String description;
  final String creatorUserId;
  final bool public;
  final DateTime updatedAt;
  final DateTime createdAt;

  final List<ExerciseMuscle>? exerciseMuscles;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.creatorUserId,
    required this.public,
    required this.updatedAt,
    required this.createdAt,
    this.exerciseMuscles,
  });
}
