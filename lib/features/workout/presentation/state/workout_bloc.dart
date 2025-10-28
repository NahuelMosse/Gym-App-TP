import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/workout.dart';
import '../../domain/usecases/get_workouts_usecase.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final GetWorkoutsUseCase getWorkoutsUseCase;

  WorkoutBloc({required this.getWorkoutsUseCase}) : super(WorkoutInitial()) {
    on<LoadWorkoutsEvent>(_onLoadWorkoutsEvent);
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
}
