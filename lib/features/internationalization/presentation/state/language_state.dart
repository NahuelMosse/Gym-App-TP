import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  // Equatable
  @override
  List<Object?> get props => [];

  // Equatable
  @override
  bool get stringify => true;
}

class LanguageInitial extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final Locale? locale; // null = system default

  const LanguageLoaded({this.locale});

  @override
  List<Object?> get props => [locale];
}

class LanguageError extends LanguageState {
  final Object exception;

  const LanguageError(this.exception);

  @override
  List<Object?> get props => [exception];
}
