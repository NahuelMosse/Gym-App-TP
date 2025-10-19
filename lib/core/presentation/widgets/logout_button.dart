import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_router.dart';
import '../../../features/auth/presentation/state/auth_bloc.dart';
import '../../../features/auth/presentation/state/auth_event.dart';
import '../../../features/internationalization/generated/translations.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);

    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: translations.signOut,
      onPressed: () {
        context.read<AuthBloc>().add(LogoutRequestedEvent());
        context.go(AppRoutes.login);
      },
    );
  }
}