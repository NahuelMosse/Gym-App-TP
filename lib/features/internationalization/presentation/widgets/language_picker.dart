import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/translations.dart';
import '../state/language_bloc.dart';
import '../state/language_event.dart';
import '../state/language_state.dart';
import '../utils/language_error_handler.dart';

class LanguageInfo {
  final String displayName;
  final String flagEmoji;

  const LanguageInfo({
    required this.displayName,
    required this.flagEmoji,
  });
}

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  static final Map<Locale, LanguageInfo> _languageInfo = {
    const Locale('en'): LanguageInfo(displayName: 'English', flagEmoji: '🇺🇸'),
    const Locale('es'): LanguageInfo(displayName: 'Español', flagEmoji: '🇪🇸'),
  };

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    
    return BlocListener<LanguageBloc, LanguageState>(
      listener: (context, state) {
        if (state is LanguageLoadedState && state.locale != null) {
          final newTranslations = lookupTranslations(state.locale!);
          final displayName = _languageInfo[state.locale]?.displayName ?? state.locale!.languageCode;
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(newTranslations.languageChangedTo(displayName)),
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is LanguageErrorState) {
          final errorMessage = LanguageErrorStateHandler.getErrorMessage(
            state.exception,
            context,
          );
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              duration: const Duration(seconds: 3),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: PopupMenuButton<Locale>(
        icon: const Icon(Icons.language),
        tooltip: translations.changeLanguage,
        onSelected: (Locale locale) {
          final bloc = context.read<LanguageBloc>();
          bloc.add(ChangeLocaleEvent(locale: locale));
        },
        itemBuilder: (BuildContext context) {
          return Translations.supportedLocales.map((locale) {
            final info = _languageInfo[locale];
            final displayName = info?.displayName ?? locale.languageCode.toUpperCase();
            final flagEmoji = info?.flagEmoji ?? '🌐';

            return PopupMenuItem<Locale>(
              value: locale,
              child: Row(
                children: [
                  Text(flagEmoji),
                  const SizedBox(width: 8),
                  Text(displayName),
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
