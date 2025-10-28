import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/internationalization/generated/translations.dart';
import '../../router/creator_router.dart';
import '../widgets/main_navigation.dart';
import '../widgets/menu_button.dart';

class CreatorPage extends StatefulWidget {
  const CreatorPage({super.key});

  @override
  State<CreatorPage> createState() => CreatorPageState();
}

class CreatorPageState extends State<CreatorPage> {
  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(
              title: translations.exercisesButton,
              onPressed: () {
                context.push(CreatorRoutes.exerciseList);
              },
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: translations.trainingDaysButton,
              onPressed: () {
                context.push(CreatorRoutes.workoutList);
              },
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: translations.routinesButton,
              subtitle: translations.routinesButtonS,
              onPressed: () {
                // TODO
              },
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: translations.advRoutinesButton,
              subtitle: translations.advRoutinesButtonS,
              onPressed: () {
                // TODO
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
