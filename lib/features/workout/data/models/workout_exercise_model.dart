import '../../../exercise/data/models/exercise_model.dart';
import '../../domain/entities/workout_exercise.dart';
import 'workout_model.dart';

class WorkoutExerciseModel {
  final String id;
  final String metodo;
  final int order;
  final int exerciseId;
  final int workoutId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final ExerciseModel? exercise;
  final WorkoutModel? workout;

  WorkoutExerciseModel({
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

  factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) {
    return WorkoutExerciseModel(
      id: json['id'],
      metodo: json['metodo'],
      order: json['order'],
      exerciseId: json['exerciseId'],
      workoutId: json['workoutId'],
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      exercise: json['exercise'] != null
          ? ExerciseModel.fromJson(json['exercise'])
          : null,
      workout: json['workout'] != null
          ? WorkoutModel.fromJson(json['workout'])
          : null,
    );
  }

  factory WorkoutExerciseModel.fromEntity(WorkoutExercise entity) {
    return WorkoutExerciseModel(
      id: entity.id,
      metodo: entity.metodo,
      order: entity.order,
      exerciseId: entity.exerciseId,
      workoutId: entity.workoutId,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
      exercise: entity.exercise != null
          ? ExerciseModel.fromEntity(entity.exercise!)
          : null,
      workout: entity.workout != null
          ? WorkoutModel.fromEntity(entity.workout!)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metodo': metodo,
      'order': order,
      'exerciseId': exerciseId,
      'workoutId': workoutId,
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      if (exercise != null) 'exercise': exercise!.toJson(),
      if (workout != null) 'workout': workout!.toJson(),
    };
  }

  WorkoutExercise toEntity() {
    return WorkoutExercise(
      id: id,
      metodo: metodo,
      order: order,
      exerciseId: exerciseId,
      workoutId: workoutId,
      updatedAt: updatedAt,
      createdAt: createdAt,
      exercise: exercise?.toEntity(),
      workout: workout?.toEntity(),
    );
  }
}
