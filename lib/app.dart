import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart';
import 'features/auth/presentation/state/auth_bloc.dart';
import 'features/auth/presentation/state/auth_event.dart';
import 'core/router/app_router.dart';

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AuthBloc>()..add(CheckAuthEvent()),
      child: MaterialApp.router(
        title: 'Gym App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF2196F3),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}