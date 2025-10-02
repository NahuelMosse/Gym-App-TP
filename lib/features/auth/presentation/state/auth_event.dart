import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  // Equatable
  @override
  List<Object?> get props => []; // Equatable will test this list of props

  // Equatable
  @override
  bool get stringify => true;
}

class LoginRequestedEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginRequestedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequestedEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {
  final bool showLoading;
  
  const CheckAuthEvent({this.showLoading = true});
  
  @override
  List<Object?> get props => [showLoading];
}