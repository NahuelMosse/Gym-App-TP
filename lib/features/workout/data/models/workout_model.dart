import '../../domain/entities/workout.dart';
import 'workout_exercise_model.dart';

class WorkoutModel {
  final String id;
  final String name;
  final String? description;
  final String userId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final List<WorkoutExerciseModel>? workoutExercises;

  WorkoutModel({
    required this.id,
    required this.name,
    this.description,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    this.workoutExercises,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      userId: json['userId'],
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      workoutExercises: json['workoutExercises'] != null
          ? (json['workoutExercises'] as List)
                .map((e) => WorkoutExerciseModel.fromJson(e))
                .toList()
          : null,
    );
  }

  factory WorkoutModel.fromEntity(Workout entity) {
    return WorkoutModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      userId: entity.userId,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
      workoutExercises: entity.workoutExercises
          ?.map((e) => WorkoutExerciseModel.fromEntity(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'userId': userId,
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      if (workoutExercises != null)
        'workoutExercises': workoutExercises!.map((e) => e.toJson()).toList(),
    };
  }

  Workout toEntity() {
    return Workout(
      id: id,
      name: name,
      description: description,
      userId: userId,
      updatedAt: updatedAt,
      createdAt: createdAt,
      workoutExercises: workoutExercises?.map((e) => e.toEntity()).toList(),
    );
  }
}
