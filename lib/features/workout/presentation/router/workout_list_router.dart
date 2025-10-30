import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/creator_router.dart';
import '../../../../injection_container.dart';
import '../../../internationalization/generated/translations.dart';
import '../state/workout_bloc.dart';
import '../widgets/workout_list.dart';

class WorkoutListRouter extends StatelessWidget {
  const WorkoutListRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              serviceLocator<WorkoutBloc>()..add(LoadWorkoutsEvent()),
        ),
      ],
      child: BlocListener<WorkoutBloc, WorkoutState>(
        listener: (context, state) async {
          if (state is WorkoutCreated) {
            await context.push(CreatorRoutes.workoutEditPath(state.workoutId));
            if (context.mounted) {
              context.read<WorkoutBloc>().add(LoadWorkoutsEvent());
            }
          }
        },
        child: BlocBuilder<WorkoutBloc, WorkoutState>(
          builder: (context, state) {
            switch (state) {
              case WorkoutLoading():
                return const Center(child: CircularProgressIndicator());
              case WorkoutError():
                return Center(child: Text('${translations.error}: ${state.exception}'));
              case WorkoutLoaded():
                return WorkoutList(workouts: state.workouts);
              case WorkoutCreated():
                return Center(child: Text(translations.loading));
              default:
                return Center(child: Text(translations.loadWorkouts));
            }
          },
        ),
      ),
    );
  }
}
