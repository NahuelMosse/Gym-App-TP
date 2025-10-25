import 'package:dio/dio.dart';
import '../models/exercise_model.dart';
import '../models/exercise_muscle_model.dart';
import '../models/muscle_model.dart';

abstract class RemoteExerciseDataSource {
  Future<ExerciseDataResponse> fetchExercises();
}

class RemoteExerciseDataSourceImpl implements RemoteExerciseDataSource {
  final Dio dio;

  RemoteExerciseDataSourceImpl({required this.dio});

  @override
  Future<ExerciseDataResponse> fetchExercises() async {
    // Simulate fetching data from a backend API
    await Future.delayed(Duration(seconds: 2));

    final muscles = [
      MuscleModel(
        id: 'm1',
        name: 'Pectorals',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm2',
        name: 'Triceps',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm3',
        name: 'Quadriceps',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm4',
        name: 'Hamstrings',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm5',
        name: 'Core',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    ];

    final exerciseMuscles = [
      ExerciseMuscleModel(
        id: 'em1',
        exerciseId: '1',
        muscleId: 'm1',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em2',
        exerciseId: '1',
        muscleId: 'm2',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em3',
        exerciseId: '2',
        muscleId: 'm3',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em4',
        exerciseId: '2',
        muscleId: 'm4',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em5',
        exerciseId: '3',
        muscleId: 'm5',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    ];

    final exercises = [
      ExerciseModel(
        id: '1',
        name: 'Push Up',
        description: 'A basic push-up exercise.',
        creatorUserId: 'user123',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '2',
        name: 'Squat',
        description: 'A basic squat exercise.',
        creatorUserId: 'user456',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '3',
        name: 'Plank',
        description: 'A basic plank exercise.',
        creatorUserId: 'user789',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    ];

    return ExerciseDataResponse(
      exercises: exercises,
      exerciseMuscles: exerciseMuscles,
      muscles: muscles,
    );
  }
}

class ExerciseDataResponse {
  final List<ExerciseModel> exercises;
  final List<ExerciseMuscleModel> exerciseMuscles;
  final List<MuscleModel> muscles;

  ExerciseDataResponse({
    required this.exercises,
    required this.exerciseMuscles,
    required this.muscles,
  });
}
