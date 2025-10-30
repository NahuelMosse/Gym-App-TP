import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/presentation/state/auth_bloc.dart';
import '../../../features/auth/presentation/state/auth_event.dart';
import '../../router/app_router.dart';
import '../../../features/internationalization/generated/translations.dart';
import '../../../features/dbviewer/presentation/widgets/debug_db_viewer.dart';
import '../widgets/main_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          const DebugDbViewer(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 24),
            Text(
              translations.welcomeToGymApp,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            Text(
              translations.mainContentHere,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequestedEvent());
                context.go(AppRoutes.login);
              },
              icon: const Icon(Icons.login),
              label: Text(translations.backToLogin),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
