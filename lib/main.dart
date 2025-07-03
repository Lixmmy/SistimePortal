import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/language/l10n/app_localizations.dart';
import 'package:newsistime/features/language/presentation/bloc/language_bloc.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'injection.dart';

void main() async{
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
      create: (context) => myInjection<LanguageBloc>()
        ..add(const GetLanguageEvent()), 
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
         
          final currentLocale = state.locale;

          return MaterialApp.router(
            routerConfig: myRouter(),
            debugShowCheckedModeBanner: false,
            locale: currentLocale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            themeMode: ThemeMode.system,
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
