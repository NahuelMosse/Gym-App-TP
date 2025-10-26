import 'package:flutter/material.dart';

import '../widgets/main_navigation.dart';

class TrainingDaysPage extends StatefulWidget {
  const TrainingDaysPage({super.key});

  @override
  State<TrainingDaysPage> createState() => _TrainingDaysPageState();
}

class _TrainingDaysPageState extends State<TrainingDaysPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Días de entrenamiento"), centerTitle: true),
      body: Center(child: Column(children: [])),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
