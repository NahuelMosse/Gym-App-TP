import 'package:flutter/material.dart';
import '../../../features/internationalization/generated/translations.dart';
import '../widgets/main_navigation.dart';
import '../widgets/menu_button.dart';
import 'exercises_page.dart';
import 'profile_page.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExercisesPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: translations.trainingDaysButton,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: translations.routinesButton,
              subtitle: translations.routinesButtonS,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: translations.advRoutinesButton,
              subtitle: translations.advRoutinesButtonS,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
