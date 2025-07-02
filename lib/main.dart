import 'package:flutter/material.dart';
import 'package:newsistime/features/language/l10n/app_localizations.dart';
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
    return MaterialApp.router(
      routerConfig: myRouter(),
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
    );
  }
}
