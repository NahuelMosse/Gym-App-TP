import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/main_navigation.dart';
import '../widgets/workout_list.dart';

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({super.key});

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Entrenamientos")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: WorkoutList(),
        ),
      ),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
