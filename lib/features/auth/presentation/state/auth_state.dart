import 'package:equatable/equatable.dart';
import '../../../../core/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  // Equatable
  @override
  List<Object?> get props => []; // Equatable will test this list of props
  
  // Equatable
  @override
  bool get stringify => true;
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final User user;

  const AuthenticatedState(this.user);

  @override
  List<Object?> get props => [user];
}

class UnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final Object exception;

  const AuthErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}