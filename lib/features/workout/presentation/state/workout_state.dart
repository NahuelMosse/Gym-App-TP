part of 'workout_bloc.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final List<Workout> workouts;

  const WorkoutLoaded(this.workouts);

  @override
  List<Object> get props => [workouts];
}

class WorkoutError extends WorkoutState {
  final Object exception;

  const WorkoutError(this.exception);

  @override
  List<Object> get props => [exception];
}

class WorkoutCreated extends WorkoutState {
  final String workoutId;

  const WorkoutCreated(this.workoutId);

  @override
  List<Object> get props => [workoutId];
}
