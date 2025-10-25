import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../state/exercise_bloc.dart';
import 'exercise_card.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              serviceLocator<ExerciseBloc>()..add(LoadExercisesEvent()),
        ),
      ],
      child: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          switch (state) {
            case ExerciseLoading():
              return const Center(child: CircularProgressIndicator());
            case ExerciseError():
              return Center(child: Text('Error: ${state.exception}'));
            case ExerciseLoaded():
              final exercises = state.exercises;

              if (exercises.isEmpty) {
                return const Center(child: Text('No exercises found.'));
              }

              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return ExerciseCard(exercise: exercises[index]);
                  },
                ),
              );
            default:
              return const Center(child: Text('Please load exercises.'));
          }
        },
      ),
    );
  }
}
