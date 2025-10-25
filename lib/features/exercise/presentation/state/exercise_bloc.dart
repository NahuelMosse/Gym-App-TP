import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/usecases/get_exercises_usecase.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final GetExercisesUseCase getExercisesUseCase;

  ExerciseBloc({required this.getExercisesUseCase}) : super(ExerciseInitial()) {
    on<LoadExercisesEvent>(_onLoadExercisesEvent);
  }

  void _onLoadExercisesEvent(
    LoadExercisesEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    emit(ExerciseLoading());
    try {
      final exercises = await getExercisesUseCase();
      emit(ExerciseLoaded(exercises));
    } catch (e) {
      emit(ExerciseError(e));
    }
  }
}
