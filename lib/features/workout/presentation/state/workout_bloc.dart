import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/workout.dart';
import '../../domain/usecases/get_workouts_usecase.dart';
import '../../domain/usecases/create_workout_usecase.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final GetWorkoutsUseCase getWorkoutsUseCase;
  final CreateWorkoutUsecase createWorkoutUseCase;

  WorkoutBloc({
    required this.getWorkoutsUseCase,
    required this.createWorkoutUseCase,
  }) : super(WorkoutInitial()) {
    on<LoadWorkoutsEvent>(_onLoadWorkoutsEvent);
    on<CreateWorkoutEvent>(_onCreateWorkoutEvent);
  }

  void _onLoadWorkoutsEvent(
    LoadWorkoutsEvent event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    try {
      final workouts = await getWorkoutsUseCase();
      emit(WorkoutLoaded(workouts));
    } catch (e) {
      emit(WorkoutError(e));
    }
  }

  void _onCreateWorkoutEvent(
    CreateWorkoutEvent event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      final workoutId = await createWorkoutUseCase();
      emit(WorkoutCreated(workoutId));
    } catch (e) {
      emit(WorkoutError(e));
    }
  }
}
