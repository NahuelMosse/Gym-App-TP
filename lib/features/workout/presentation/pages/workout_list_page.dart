import 'package:flutter/material.dart';
import '../../../internationalization/generated/translations.dart';
import '../../../../core/presentation/widgets/main_navigation.dart';
import '../router/workout_list_router.dart';

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({super.key});

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    
    return Scaffold(
      appBar: AppBar(title: Text(translations.workoutListTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: WorkoutListRouter(),
        ),
      ),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
