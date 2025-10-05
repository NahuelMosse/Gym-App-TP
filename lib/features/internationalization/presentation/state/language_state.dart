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

class LanguageInitialState extends LanguageState {}

class LanguageLoadedState extends LanguageState {
  final Locale? locale; // null = system default

  const LanguageLoadedState({this.locale});

  @override
  List<Object?> get props => [locale];
}

class LanguageErrorState extends LanguageState {
  final Object exception;

  const LanguageErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}
