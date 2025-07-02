// lib/features/language/presentation/pages/selection_language.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/language/l10n/app_localizations.dart'; // Untuk lokalisasi string
import 'package:newsistime/features/language/domain/entities/app_language.dart'; // Penting: Import AppLanguage entity
import 'package:newsistime/features/language/presentation/bloc/language_bloc.dart';

import '../../../../core/loading/loading_manage.dart';

class SelectionLanguagePage extends StatefulWidget {
  const SelectionLanguagePage({super.key});

  @override
  State<SelectionLanguagePage> createState() => _SelectionLanguagePageState();
}

class _SelectionLanguagePageState extends State<SelectionLanguagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.selectLanguage)),
      body: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (state is LanguageLoading) {
            LoadingManager().show(context);
          } else {
            if (LoadingManager().isShowing) {
              LoadingManager().dismiss();
            }
          }

          if (state is LanguageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is LanguageLoaded) {
            // Tampilkan snackbar konfirmasi dan tutup halaman
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(appLocalizations.languageChangedConfirmation(state.locale.languageCode == 'en' ? 'English' : 'Bahasa Indonesia')), // Gunakan nama bahasa yang sesuai
                duration: const Duration(seconds: 2),
              ),
            );
            // Tutup halaman setelah bahasa berhasil dimuat
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          // Jika state adalah LanguageInitial, muat bahasa.
          // Ini penting untuk memastikan currentLocale tidak null pada build pertama.
          if (state is LanguageInitial) {
            context.read<LanguageBloc>().add(const GetLanguageEvent());
            return const Center(child: CircularProgressIndicator()); // Tampilkan loading sampai bahasa dimuat
          }

          if (state is LanguageLoaded || state is LanguageLoading || state is LanguageError) { // Tangani semua state
            final currentLocale = state.locale; // Locale selalu ada di LanguageState

            return ListView.separated(
              itemCount: AppLanguage.values.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final appLanguage = AppLanguage.values[index];
                final isSelected = currentLocale.languageCode == appLanguage.locale.languageCode;

                return ListTile(
                  title: Text(appLanguage.name),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                  onTap: () {
                    if (!isSelected) {
                      context.read<LanguageBloc>().add(
                        LanguageChangedEvent(appLanguage),
                      );
                    }
                    // Jangan pop di sini, biarkan listener yang menangani pop setelah sukses
                  },
                );
              },
            );
          }
          // Fallback untuk state yang tidak terduga
          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}