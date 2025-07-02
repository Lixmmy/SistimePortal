// lib/features/language/domain/entities/app_language.dart
import 'package:flutter/material.dart';

enum AppLanguage {
  english(Locale('en'), 'English'),
  indonesian(Locale('id'), 'Bahasa Indonesia');

  final Locale locale;
  final String name;

  const AppLanguage(this.locale, this.name);

  // Metode untuk mendapatkan AppLanguage dari kode bahasa (String)
  static AppLanguage fromLanguageCode(String languageCode) {
    return AppLanguage.values.firstWhere(
      (appLang) => appLang.locale.languageCode == languageCode,
      orElse: () => AppLanguage.english, // Default jika tidak ditemukan
    );
  }
}
