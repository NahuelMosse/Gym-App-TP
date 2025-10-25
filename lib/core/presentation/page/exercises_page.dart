import 'package:flutter/material.dart';
import '../../../features/exercise/presentation/widgets/exercise_list.dart';
import '../widgets/main_navigation.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => ExercisesPageState();
}

class ExercisesPageState extends State<ExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [ExerciseList()],
      ),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
