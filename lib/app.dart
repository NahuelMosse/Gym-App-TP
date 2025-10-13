import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart';
import 'features/auth/presentation/state/auth_bloc.dart';
import 'features/auth/presentation/state/auth_event.dart';
import 'features/internationalization/presentation/state/language_bloc.dart';
import 'features/internationalization/presentation/state/language_event.dart';
import 'features/internationalization/presentation/state/language_state.dart';
import 'core/router/app_router.dart';
import 'features/internationalization/generated/translations.dart';
import 'core/theme/app_theme.dart';

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>()..add(CheckAuthEvent()),
        ),
        BlocProvider(
          create: (context) => serviceLocator<LanguageBloc>()..add(const LoadSavedLocaleEvent()),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          // Extract language from state
          Locale? currentLocale;
          if (languageState is LanguageLoadedState) {
            currentLocale = languageState.locale;
          }

          return MaterialApp.router(
            title: 'Gym App', // Fallback title
            onGenerateTitle: (context) => Translations.of(context).appName,
            localizationsDelegates: Translations.localizationsDelegates,
            supportedLocales: Translations.supportedLocales,
            locale: currentLocale, // Bind to LanguageBloc state
            theme: AppTheme.darkTheme,
            routerConfig: AppRouter.router(context.read<AuthBloc>()),
          );
        },
      ),
    );
  }
}