import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/widgets/add_card.dart';
import '../../../../injection_container.dart';
import '../state/workout_bloc.dart';
import 'workout_card.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              serviceLocator<WorkoutBloc>()..add(LoadWorkoutsEvent()),
        ),
      ],
      child: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          switch (state) {
            case WorkoutLoading():
              return const Center(child: CircularProgressIndicator());
            case WorkoutError():
              return Center(child: Text('Error: ${state.exception}'));
            case WorkoutLoaded():
              final workouts = state.workouts;

              if (workouts.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      AddCard(),
                    ],
                  ),
                );
              }

              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: workouts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == workouts.length) {
                      return AddCard(
                        onTap: () {
                          // TODO: ir a la pantalla de añadir workout (context.push())
                        },
                      );
                    }
                    return WorkoutCard(workout: workouts[index]);
                  },
                ),
              );
            default:
              return const Center(child: Text('Please load workouts.'));
          }
        },
      ),
    );
  }
}
