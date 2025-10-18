import 'package:flutter/material.dart';

class DumbbellPage extends StatefulWidget {
  const DumbbellPage({super.key});

  @override
  State<DumbbellPage> createState() => DumbbellPageState();
}

class DumbbellPageState extends State<DumbbellPage> {
  void refreshData() {
    // lógica para recargar la data
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Dumbbell Page'));
  }
}
