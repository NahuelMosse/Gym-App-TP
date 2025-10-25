part of 'exercise_bloc.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<Exercise> exercises;

  const ExerciseLoaded(this.exercises);

  @override
  List<Object> get props => [exercises];
}

class ExerciseError extends ExerciseState {
  final Object exception;

  const ExerciseError(this.exception);

  @override
  List<Object> get props => [exception];
}
