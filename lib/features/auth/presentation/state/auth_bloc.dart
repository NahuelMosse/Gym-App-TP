import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../../../core/interfaces/base_interfaces.dart';
import '../../../../core/errors/exception_mapper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitialState()) {
    on<CheckAuthEvent>(_onCheckAuth);
    on<LoginRequestedEvent>(_onLoginRequested);
    on<LogoutRequestedEvent>(_onLogoutRequested);
  }

  Future<void> _onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    if (event.showLoading) {
      emit(AuthLoadingState());
    }
    
    try {
      final user = await getCurrentUserUseCase(NoParams());
      if (user != null) {
        emit(AuthenticatedState(user));
      } else {
        emit(UnauthenticatedState());
      }
    } catch (e) {
      final domainEx = mapExceptionToDomain(e);
      // If token invalid/expired, ensure unauthenticated. Otherwise still unauthenticated.
      if (domainEx is UnauthorizedException || domainEx is TokenExpiredException) {
        emit(UnauthenticatedState());
      } else {
        emit(UnauthenticatedState());
      }
    }
  }

  Future<void> _onLoginRequested(LoginRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    
    try {
      final user = await loginUseCase(LoginParams(
        email: event.email,
        password: event.password,
      ));
      emit(AuthenticatedState(user));
    } catch (e) {
      final domainEx = mapExceptionToDomain(e);
      final message = mapExceptionToMessage(domainEx);
      emit(AuthErrorState(message));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequestedEvent event, Emitter<AuthState> emit) async {
    emit(UnauthenticatedState());

    try {
      await logoutUseCase(NoParams());
    } catch (e) {
      // Ignore logout errors, user is already logged out in UI
    }
  }
}