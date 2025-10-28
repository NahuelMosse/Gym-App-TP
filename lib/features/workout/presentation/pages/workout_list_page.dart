import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/main_navigation.dart';

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({super.key});

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Entrenamientos"), centerTitle: true),
      body: Center(child: Column(children: [])),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
