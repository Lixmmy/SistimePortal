import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/language/presentation/bloc/language_bloc.dart';
import 'package:newsistime/features/language/presentation/pages/selection_language.dart';
import '../../features/profil/presentation/bloc/profil_bloc.dart';
import '../../features/profil/presentation/pages/info_profile.dart';
import '../../features/profil/presentation/pages/profil_page.dart';
import '../../injection.dart';

GoRouter myRouter() {
  return GoRouter(
    initialLocation: '/profil_page',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => ProfilBloc(getMahasiswa: myInjection()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/profil_page',
            name: 'profilPage',
            builder: (context, state) => ProfilPage(),
          ),
          GoRoute(
            path: '/info_profil_page',
            name: 'infoProfilPage',
            builder: (context, state) => InfoProfilePage(),
          ),
        ],
      ),
      GoRoute(path: '/selection_language', name: 'selectionLanguage', builder: (context, state) {
        return BlocProvider(
          create: (context) => LanguageBloc(getCurrentLanguage: myInjection(), setLanguage: myInjection()),
          child: SelectionLanguagePage(),
        );
      })
    ],
  );
}
