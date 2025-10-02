import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart';
import 'features/auth/presentation/state/auth_bloc.dart';
import 'features/auth/presentation/state/auth_event.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/router/auth_router.dart';
import 'core/presentation/page/home_page.dart';

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196F3),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => serviceLocator<AuthBloc>()..add(CheckAuthEvent()),
        child: const AuthRouter(),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}