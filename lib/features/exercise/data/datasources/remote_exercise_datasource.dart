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
    await Future.delayed(const Duration(seconds: 0));

    final muscles = [
      MuscleModel(
        id: 'm1',
        name: 'Pectorales',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm2',
        name: 'Tríceps',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm3',
        name: 'Cuádriceps',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm4',
        name: 'Isquiotibiales',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm5',
        name: 'Core',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm6',
        name: 'Bíceps',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm7',
        name: 'Espalda',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm8',
        name: 'Glúteos',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm9',
        name: 'Hombros',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      MuscleModel(
        id: 'm10',
        name: 'Pantorrillas',
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
      ExerciseMuscleModel(
        id: 'em6',
        exerciseId: '4',
        muscleId: 'm1',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em7',
        exerciseId: '4',
        muscleId: 'm2',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em8',
        exerciseId: '5',
        muscleId: 'm3',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em9',
        exerciseId: '5',
        muscleId: 'm4',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em10',
        exerciseId: '5',
        muscleId: 'm7',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em11',
        exerciseId: '6',
        muscleId: 'm6',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em12',
        exerciseId: '7',
        muscleId: 'm2',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em13',
        exerciseId: '8',
        muscleId: 'm3',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em14',
        exerciseId: '8',
        muscleId: 'm4',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em15',
        exerciseId: '8',
        muscleId: 'm8',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em16',
        exerciseId: '9',
        muscleId: 'm9',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em17',
        exerciseId: '10',
        muscleId: 'm7',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em18',
        exerciseId: '10',
        muscleId: 'm6',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em19',
        exerciseId: '11',
        muscleId: 'm3',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em20',
        exerciseId: '11',
        muscleId: 'm8',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em21',
        exerciseId: '12',
        muscleId: 'm5',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em22',
        exerciseId: '13',
        muscleId: 'm5',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em23',
        exerciseId: '14',
        muscleId: 'm4',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em24',
        exerciseId: '15',
        muscleId: 'm10',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em25',
        exerciseId: '16',
        muscleId: 'm1',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em26',
        exerciseId: '17',
        muscleId: 'm7',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em27',
        exerciseId: '18',
        muscleId: 'm5',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em28',
        exerciseId: '19',
        muscleId: 'm2',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseMuscleModel(
        id: 'em29',
        exerciseId: '20',
        muscleId: 'm5',
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    ];

    final exercises = [
      ExerciseModel(
        id: '1',
        name: 'Flexión de brazos',
        description: 'Ejercicio básico de flexión para pecho y tríceps.',
        creatorUserId: 'user1',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '2',
        name: 'Sentadilla',
        description: 'Sentadilla básica para piernas.',
        creatorUserId: 'user2',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '3',
        name: 'Plancha',
        description: 'Ejercicio básico de plancha para el core.',
        creatorUserId: 'user3',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '4',
        name: 'Press de banca',
        description: 'Press de pecho con barra.',
        creatorUserId: 'user4',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '5',
        name: 'Peso muerto',
        description: 'Ejercicio de fuerza para todo el cuerpo.',
        creatorUserId: 'user5',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '6',
        name: 'Curl de bíceps',
        description: 'Curl con mancuernas para bíceps.',
        creatorUserId: 'user6',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '7',
        name: 'Fondos de tríceps',
        description: 'Fondos usando barras paralelas.',
        creatorUserId: 'user7',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '8',
        name: 'Zancada',
        description: 'Zancada hacia adelante para piernas y glúteos.',
        creatorUserId: 'user8',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '9',
        name: 'Press militar',
        description: 'Press por encima de la cabeza para hombros.',
        creatorUserId: 'user9',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '10',
        name: 'Dominadas',
        description: 'Dominadas para espalda y bíceps.',
        creatorUserId: 'user10',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '11',
        name: 'Prensa de piernas',
        description: 'Prensa de piernas en máquina.',
        creatorUserId: 'user11',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '12',
        name: 'Crunch abdominal',
        description: 'Ejercicio de abdominales.',
        creatorUserId: 'user12',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '13',
        name: 'Giro ruso',
        description: 'Ejercicio para oblicuos y core.',
        creatorUserId: 'user13',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '14',
        name: 'Curl de isquiotibiales',
        description: 'Curl en máquina para isquiotibiales.',
        creatorUserId: 'user14',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '15',
        name: 'Elevación de talones',
        description: 'Elevación de pantorrillas de pie.',
        creatorUserId: 'user15',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '16',
        name: 'Aperturas con mancuernas',
        description: 'Aperturas para pecho con mancuernas.',
        creatorUserId: 'user16',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '17',
        name: 'Remo con mancuernas',
        description: 'Ejercicio de espalda con mancuernas.',
        creatorUserId: 'user17',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '18',
        name: 'Escalador',
        description: 'Ejercicio de cardio y core.',
        creatorUserId: 'user18',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '19',
        name: 'Extensión de tríceps por encima de la cabeza',
        description: 'Tríceps con mancuerna.',
        creatorUserId: 'user19',
        public: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      ExerciseModel(
        id: '20',
        name: 'Plancha lateral',
        description: 'Ejercicio de oblicuos y core.',
        creatorUserId: 'user20',
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
