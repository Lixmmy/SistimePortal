// lib/features/language/presentation/pages/selection_language.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/custom_widgets/appbarcustom.dart';
import 'package:newsistime/l10n/app_localizations.dart'; // Untuk lokalisasi string
import 'package:newsistime/features/language/domain/entities/app_language.dart'; // Penting: Import AppLanguage entity
import 'package:newsistime/features/language/presentation/bloc/language_bloc.dart';

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
      appBar: AppBarCustom(title: appLocalizations.selectLanguage),
      body: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (state is LanguageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is LanguageChangedSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is LanguageLoaded ||
              state is LanguageError ||
              state is LanguageInitial) {
            final currentLocale =
                state.locale;

            return ListView.separated(
              itemCount: AppLanguage.values.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final appLanguage = AppLanguage.values[index];
                final isSelected =
                    currentLocale.languageCode ==
                    appLanguage.locale.languageCode;

                return ListTile(
                  title: Text(appLanguage.name, style: Theme.of(context).textTheme.labelSmall,),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                  onTap: () {
                    if (!isSelected) {
                      context.read<LanguageBloc>().add(
                        LanguageChangedEvent(appLanguage),
                      );
                    }
                  },
                );
              },
            );
          }
          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
