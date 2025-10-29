import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/widgets/add_card.dart';
import '../../domain/entities/workout.dart';
import '../state/workout_bloc.dart';
import 'workout_card.dart';

class WorkoutList extends StatelessWidget {
  final List<Workout> workouts;

  const WorkoutList({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {

    void createWorkout() {
      context.read<WorkoutBloc>().add(
        CreateWorkoutEvent(),
      );
    }

    if (workouts.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            AddCard(
              onTap: () { createWorkout(); },
            ),
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
              onTap: () { createWorkout(); },
            );
          }
          return WorkoutCard(workout: workouts[index]);
        },
      ),
    );
  }
}
