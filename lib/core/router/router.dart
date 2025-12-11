import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/forgot_password/presentation/pages/forgot_password_page.dart';
import 'package:newsistime/features/home/presentation/pages/home_page.dart';
import 'package:newsistime/features/home/presentation/pages/selected_page.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:newsistime/features/khs/presentation/pages/detail_khs.dart';
import 'package:newsistime/features/khs/presentation/pages/khs_page.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/features/krs/presentation/pages/detail_krs.dart';
import 'package:newsistime/features/krs/presentation/pages/krs_page.dart';
import 'package:newsistime/features/language/presentation/pages/selection_language.dart';
import 'package:newsistime/features/login/presentation/bloc/login_bloc.dart';
import 'package:newsistime/features/login/presentation/pages/login_page.dart';
import 'package:newsistime/features/nilai/presentation/pages/nilai_page.dart';
import 'package:newsistime/features/pam/presentation/pages/pam_page.dart';
import 'package:newsistime/features/profil/presentation/pages/edit_profile.dart';
import 'package:newsistime/features/profil/presentation/pages/id_card.dart';
import 'package:newsistime/features/register/presentation/pages/register_page.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';
import 'package:newsistime/features/transkrip/presentation/pages/transkrip_page.dart';
import '../../features/profil/presentation/bloc/profil_bloc.dart';
import '../../features/profil/presentation/pages/info_profile.dart';
import '../../features/profil/presentation/pages/profil_page.dart';
import '../../features/login/presentation/pages/launcher_page.dart';
import '../../injection.dart';

GoRouter myRouter() {
  return GoRouter(
    initialLocation: '/launcher_page',
    // redirect: (context, state) {

    // },
    routes: [
      GoRoute(
        path: '/launcher_page',
        name: 'launcherPage',
        builder: (context, state) => const LauncherPage(),
      ),
      GoRoute(
        path: '/login_page',
        name: 'loginPage',
        builder: (context, state) => BlocProvider(
          create: (context) => LoginBloc(postLoginUseCases: myInjection()),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/forgot_password_page',
        name: 'forgotPasswordPage',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/register_page',
        name: 'registerPage',
        builder: (context, state) => const RegisterPage(),
      ),
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
          GoRoute(
            path: '/edit_profil_page',
            name: 'editProfilPage',
            builder: (context, state) => EditProfile(),
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
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) =>
                KrsBloc(getKrs: myInjection(), profilBloc: myInjection()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/krs_page',
            name: 'krsPage',
            builder: (context, state) => KrsPage(),
          ),
          GoRoute(
            path: '/detail_krs_page',
            name: 'detailKrsPage',
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              final int semester = data['semester'];
              return DetailKrs(semester: semester);
            },
          ),
        ],
      ),
      GoRoute(
        path: 'nilai_page',
        name: 'nilaiPage',
        builder: (context, state) => const NilaiPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) =>
                KhsBloc(getKhs: myInjection(), profilBloc: myInjection()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/khs_page',
            name: 'khsPage',
            builder: (context, state) => KhsPage(),
          ),
          GoRoute(
            path: '/detail_khs_page',
            name: 'detailKhsPage',
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              final int semester = data['semester'];
              return DetailKhs(semester: semester);
            },
          ),
        ],
      ),
      GoRoute(
        path: 'pam_page',
        name: 'pamPage',
        builder: (context, state) => const PamPage(),
      ),
      GoRoute(
        path: 'transkrip_page',
        name: 'transkripPage',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => TranskripBloc(
              getTranskrip: myInjection(),
              profilBloc: myInjection(),
            ),
            child: TranskripPage(),
          );
        },
      ),
    ],
  );
}
