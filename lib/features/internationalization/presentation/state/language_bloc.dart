import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_current_locale_usecase.dart';
import '../../domain/usecases/change_locale_usecase.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetCurrentLocaleUseCase getCurrentLocaleUseCase;
  final ChangeLocaleUseCase changeLocaleUseCase;

  LanguageBloc({
    required this.getCurrentLocaleUseCase,
    required this.changeLocaleUseCase,
  }) : super(LanguageInitial()) {
    on<LoadSavedLocaleEvent>(_onLoadSavedLocale);
    on<ChangeLocaleEvent>(_onChangeLocale);
  }

  Future<void> _onLoadSavedLocale(
    LoadSavedLocaleEvent event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      final locale = await getCurrentLocaleUseCase();
      emit(LanguageLoaded(locale: locale));
    } catch (e) {
      emit(LanguageError(e));
      emit(const LanguageLoaded(locale: null));
    }
  }

  Future<void> _onChangeLocale(
    ChangeLocaleEvent event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      await changeLocaleUseCase(event.locale);
      emit(LanguageLoaded(locale: event.locale));
    } catch (e) {
      emit(LanguageError(e));
    }
  }
}
