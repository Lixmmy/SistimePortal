import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart'; // Hubungkan dengan file event
part 'language_state.dart'; // Hubungkan dengan file state

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  // Inisialisasi Bloc dengan state awal (misalnya, bahasa Inggris)
  LanguageBloc() : super(const LanguageState(Locale('id', ''))) {
    // Daftarkan handler untuk event LanguageChanged
    on<LanguageChanged>((event, emit) {
      emit(LanguageState(event.locale));
      // Anda bisa menambahkan logika untuk menyimpan locale ke shared_preferences di sini
      // _saveLocaleToPreferences(event.locale);
    });
  }

  // Opsional: Fungsi untuk menyimpan locale ke shared_preferences
  // Future<void> _saveLocaleToPreferences(Locale locale) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('languageCode', locale.languageCode);
  // }

  // Opsional: Fungsi untuk memuat locale dari shared_preferences saat inisialisasi
  // Future<void> _loadLocaleFromPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? langCode = prefs.getString('languageCode');
  //   if (langCode != null && state.locale.languageCode != langCode) {
  //     add(LanguageChanged(Locale(langCode)));
  //   }
  // }

  // Daftar bahasa yang didukung (bisa juga dari AppLocalizations.supportedLocales)
  List<Locale> get supportedLocales => const [
        Locale('en', ''),
        Locale('id', ''),
        // Tambahkan locale lain jika ada
      ];
}
