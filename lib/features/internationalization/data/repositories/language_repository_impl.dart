import 'package:flutter/material.dart';
import '../../domain/repositories/language_repository.dart';
import '../datasources/language_local_data_source.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageLocalDataSource localDataSource;

  LanguageRepositoryImpl({required this.localDataSource});

  @override
  Future<Locale?> getSavedLocale() async {
    return await localDataSource.getSavedLocale();
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await localDataSource.saveLocale(locale);
  }

  @override
  Future<void> clearSavedLocale() async {
    await localDataSource.clearSavedLocale();
  }
}
