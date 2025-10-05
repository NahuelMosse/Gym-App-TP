import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  // Equatable
  @override
  List<Object?> get props => [];

  // Equatable
  @override
  bool get stringify => true;
}

class LoadSavedLocaleEvent extends LanguageEvent {
  const LoadSavedLocaleEvent();
}

class ChangeLocaleEvent extends LanguageEvent {
  final Locale locale;

  const ChangeLocaleEvent({required this.locale});

  @override
  List<Object?> get props => [locale];
}

