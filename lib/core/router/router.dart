import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/home/presentation/pages/home_page.dart';
import 'package:newsistime/features/home/presentation/pages/selected_page.dart';
import 'package:newsistime/features/language/presentation/pages/selection_language.dart';
import 'package:newsistime/features/profil/presentation/pages/id_card.dart';
import '../../features/profil/presentation/bloc/profil_bloc.dart';
import '../../features/profil/presentation/pages/info_profile.dart';
import '../../features/profil/presentation/pages/profil_page.dart';
import '../../injection.dart';

GoRouter myRouter() {
  return GoRouter(
    initialLocation: '/selected_page',
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
      GoRoute(
        path: '/selection_language',
        name: 'selectionLanguage',
        builder: (context, state) {
          return SelectionLanguagePage();
        },
      ),
      GoRoute(
        path: '/id_card',
        name: 'idCard',
        builder: (context, state) {
          return IdCard();
        },
      ),
      GoRoute(
        path: '/home_page',
        name: 'homePage',
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/selected_page',
        name: 'selectedPage',
        builder: (context, state) {
          return const SelectedPage();
        },
      ),
    ],
  );
}
