part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class LoadWorkoutsEvent extends WorkoutEvent {}

class CreateWorkoutEvent extends WorkoutEvent {
  const CreateWorkoutEvent();

  @override
  List<Object> get props => [];
}
