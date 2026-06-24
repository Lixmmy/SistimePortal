import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sistime_portal/core/localization/l10n/app_localizations.dart';
import 'package:sistime_portal/core/localization/localization_service.dart';
import 'package:sistime_portal/features/language/presentation/bloc/language_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          myInjection<LanguageBloc>()..add(const GetLanguageEvent()),
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
            darkTheme: AppTheme.darkTheme,
            builder: (context, child) {
              final l10n = AppLocalizations.of(context);
              if (l10n != null) setLocalization(l10n);
              return child ?? const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
