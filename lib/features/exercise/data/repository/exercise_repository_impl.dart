import '../../../../core/errors/exception_mapper.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../datasources/database_exercise_datasource.dart';
import '../datasources/remote_exercise_datasource.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final DatabaseExerciseDataSource databaseDataSource;
  final RemoteExerciseDataSource remoteDataSource;

  ExerciseRepositoryImpl({
    required this.databaseDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Exercise>> getExercises() async {
    try {
      final localExercises = await databaseDataSource.fetchExercises();

      if (localExercises.isNotEmpty) {
        return localExercises.map((e) => e.toEntity()).toList();
      }

      await refreshExercisesFromBackend();
      return getExercises();
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }

  @override
  Future<void> refreshExercisesFromBackend() async {
    try {
      final response = await remoteDataSource.fetchExercises();
      final exercises = response.exercises;
      final exerciseMuscles = response.exerciseMuscles;
      final muscles = response.muscles;

      await databaseDataSource.saveExercises(exercises);
      await databaseDataSource.saveMuscle(muscles);
      await databaseDataSource.saveExerciseMuscle(exerciseMuscles);
    } catch (e) {
      throw mapExceptionToDomain(e);
    }
  }
}
