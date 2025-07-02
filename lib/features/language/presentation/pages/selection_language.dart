// lib/features/language/presentation/pages/language_selection_page.dart (bagian relevan)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc
import 'package:newsistime/features/language/l10n/app_localizations.dart';
import 'package:newsistime/features/language/presentation/bloc/language_bloc.dart';

// ...

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final languageBloc = BlocProvider.of<LanguageBloc>(context); 

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.localeName,
        ),
        backgroundColor: const Color.fromARGB(255, 95, 189, 252),
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: languageBloc.supportedLocales.length, // Gunakan supportedLocales dari Bloc
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final locale = languageBloc.supportedLocales[index];
          String languageName;

          switch (locale.languageCode) {
            case 'en':
              languageName = 'English';
              break;
            case 'id':
              languageName = 'Bahasa Indonesia';
              break;
            default:
              languageName = locale.languageCode;
          }

          // Perhatikan bahwa di Bloc, currentLocale didapatkan dari state
          final isSelected = languageBloc.state.locale.languageCode == locale.languageCode;

          return ListTile(
            title: Text(languageName),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.blue)
                : null,
            onTap: () {
              if (!isSelected) {
                languageBloc.add(LanguageChanged(locale)); // Kirim event ke Bloc
                
              }
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
