import '../../domain/entities/exercise_muscle.dart';
import 'muscle_model.dart';

class ExerciseMuscleModel {
  final String id;
  final String muscleId;
  final String exerciseId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final MuscleModel? muscle;

  ExerciseMuscleModel({
    required this.id,
    required this.muscleId,
    required this.exerciseId,
    required this.updatedAt,
    required this.createdAt,
    this.muscle,
  });

  factory ExerciseMuscleModel.fromJson(Map<String, dynamic> json) {
    return ExerciseMuscleModel(
      id: json['id'],
      muscleId: json['muscleId'],
      exerciseId: json['exerciseId'],
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      muscle: json['muscle'] != null
          ? MuscleModel.fromJson(json['muscle'])
          : null,
    );
  }

  factory ExerciseMuscleModel.fromEntity(ExerciseMuscle entity) {
    return ExerciseMuscleModel(
      id: entity.id,
      muscleId: entity.muscleId,
      exerciseId: entity.exerciseId,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
      muscle: entity.muscle != null
          ? MuscleModel.fromEntity(entity.muscle!)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'muscleId': muscleId,
      'exerciseId': exerciseId,
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      if (muscle != null) 'muscle': muscle!.toJson(),
    };
  }

  ExerciseMuscle toEntity() {
    return ExerciseMuscle(
      id: id,
      muscleId: muscleId,
      exerciseId: exerciseId,
      updatedAt: updatedAt,
      createdAt: createdAt,
      muscle: muscle?.toEntity(),
    );
  }
}
