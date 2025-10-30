import '../../domain/entities/muscle.dart';
import 'exercise_muscle_model.dart';

class MuscleModel {
  final String id;
  final String name;
  final DateTime updatedAt;
  final DateTime createdAt;
  final List<ExerciseMuscleModel>? exerciseMuscles;

  MuscleModel({
    required this.id,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    this.exerciseMuscles,
  });

  factory MuscleModel.fromJson(Map<String, dynamic> json) {
    return MuscleModel(
      id: json['id'],
      name: json['name'],
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      exerciseMuscles: json['exerciseMuscles'] != null
          ? (json['exerciseMuscles'] as List)
                .map((e) => ExerciseMuscleModel.fromJson(e))
                .toList()
          : null,
    );
  }

  factory MuscleModel.fromEntity(Muscle entity) {
    return MuscleModel(
      id: entity.id,
      name: entity.name,
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
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      if (exerciseMuscles != null)
        'exerciseMuscles': exerciseMuscles!.map((e) => e.toJson()).toList(),
    };
  }

  Muscle toEntity() {
    return Muscle(
      id: id,
      name: name,
      updatedAt: updatedAt,
      createdAt: createdAt,
      exerciseMuscles: exerciseMuscles?.map((e) => e.toEntity()).toList(),
    );
  }
}
