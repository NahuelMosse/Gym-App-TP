import 'package:flutter/material.dart';
import '../widgets/exercise_list.dart';
import '../../../../core/presentation/widgets/main_navigation.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key});

  @override
  State<ExerciseListPage> createState() => ExerciseListPageState();
}

class ExerciseListPageState extends State<ExerciseListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ExerciseList(),
        ),
      ),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
