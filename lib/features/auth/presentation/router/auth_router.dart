import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/auth_bloc.dart';
import '../state/auth_state.dart';
import '../pages/login_page.dart';
import '../utils/auth_error_handler.dart';
import '../../../../core/presentation/page/home_page.dart';
import '../../../../core/presentation/page/loading_page.dart';
import '../../../internationalization/generated/translations.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return switch (state) {
          AuthLoadingState() => LoadingPage(
            message: translations.verifyingAuth,
          ),
          AuthenticatedState() => const HomePage(),
          AuthErrorState() => LoginPage(
            errorMessage: AuthErrorHandler.getErrorMessage(state.exception, context),
          ),
          // default (Initial, Unauthenticated)
          _ => const LoginPage(),
        };
      },
    );
  }
}