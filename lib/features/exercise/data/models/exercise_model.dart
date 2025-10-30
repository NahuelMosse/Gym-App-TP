import '../../domain/entities/exercise.dart';
import 'exercise_muscle_model.dart';

class ExerciseModel {
  final String id;
  final String name;
  final String description;
  final String creatorUserId;
  final bool public;
  final DateTime updatedAt;
  final DateTime createdAt;
  final List<ExerciseMuscleModel>? exerciseMuscles;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.creatorUserId,
    required this.public,
    required this.updatedAt,
    required this.createdAt,
    this.exerciseMuscles,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      creatorUserId: json['creatorUserId'],
      public: json['public'],
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      exerciseMuscles: json['exerciseMuscles'] != null
          ? (json['exerciseMuscles'] as List)
                .map((e) => ExerciseMuscleModel.fromJson(e))
                .toList()
          : null,
    );
  }

  factory ExerciseModel.fromEntity(Exercise entity) {
    return ExerciseModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      creatorUserId: entity.creatorUserId,
      public: entity.public,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
      exerciseMuscles: entity.exerciseMuscles
          ?.map((e) => ExerciseMuscleModel.fromEntity(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'creatorUserId': creatorUserId,
      'public': public,
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      if (exerciseMuscles != null)
        'exerciseMuscles': exerciseMuscles!.map((e) => e.toJson()).toList(),
    };
  }

  Exercise toEntity() {
    return Exercise(
      id: id,
      name: name,
      description: description,
      creatorUserId: creatorUserId,
      public: public,
      updatedAt: updatedAt,
      createdAt: createdAt,
      exerciseMuscles: exerciseMuscles?.map((e) => e.toEntity()).toList(),
    );
  }
}
