import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/presentation/state/auth_bloc.dart';
import '../../../features/auth/presentation/state/auth_event.dart';
import '../../router/app_router.dart';
import '../../../features/internationalization/generated/translations.dart';
import '../../../features/internationalization/presentation/widgets/language_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${translations.appName} - ${translations.homeTitle}'),
        actions: [
          const LanguagePicker(),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: translations.signOut,
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequestedEvent());
              context.go(AppRoutes.login);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 24),
            Text(
              translations.welcomeToGymApp,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              translations.mainContentHere,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
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
    );
  }
}