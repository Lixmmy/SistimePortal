import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/features/agama/presentation/bloc/agama_bloc.dart';
import 'package:newsistime/features/forgot_password/presentation/pages/forgot_password_page.dart';
import 'package:newsistime/features/home/presentation/pages/home_page.dart';
import 'package:newsistime/features/home/presentation/pages/selected_page.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:newsistime/features/khs/presentation/pages/detail_khs.dart';
import 'package:newsistime/features/khs/presentation/pages/khs_page.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/features/krs/presentation/pages/detail_krs.dart';
// import 'package:newsistime/features/krs/presentation/pages/detail_krs.dart';
import 'package:newsistime/features/krs/presentation/pages/krs_page.dart';
import 'package:newsistime/features/language/presentation/pages/selection_language.dart';
import 'package:newsistime/features/login/presentation/bloc/login_bloc.dart';
import 'package:newsistime/features/login/presentation/pages/login_page.dart';
import 'package:newsistime/features/nilai/presentation/pages/nilai_page.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/presentation/pages/edit_profile_page.dart';
import 'package:newsistime/features/profil/presentation/pages/id_card_page.dart';
import 'package:newsistime/features/status/presentation/bloc/status_bloc.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';
import 'package:newsistime/features/transkrip/presentation/pages/transkrip_page.dart';
import '../../features/profil/presentation/bloc/profil_bloc.dart';
import '../../features/profil/presentation/pages/info_profile_page.dart';
import '../../features/profil/presentation/pages/profil_page.dart';
import '../../features/login/presentation/pages/launcher_page.dart';
import '../../injection.dart';

GoRouter myRouter() {
  return GoRouter(
    initialLocation: '/launcher_page',
    redirect: (context, state) async {
      final secureStorage = myInjection<SecureStorage>();
      final token = await secureStorage.getData('token');
      final bool isAuthenticated = token.isNotEmpty;
      final String currentPath = state.uri.path;

      final bool isGuestRoute =
          currentPath == '/launcher_page' ||
          currentPath == '/login_page' ||
          currentPath == '/forgot_password_page';

      if (!isAuthenticated) {
        if (isGuestRoute) {
          return null;
        }
        return '/launcher_page';
      }

      if (isGuestRoute) {
        return '/selected_page';
      }

      return null;
    },
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
          create: (context) => LoginBloc(
            postLoginUseCases: myInjection(),
            loginLocalDataSource: myInjection(),
            localAuthentication: myInjection(),
          ),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/forgot_password_page',
        name: 'forgotPasswordPage',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: myInjection<ProfilBloc>()),
              BlocProvider(
                create: (context) => AgamaBloc(getAgama: myInjection()),
              ),
              BlocProvider(
                create: (context) => StatusBloc(getStatus: myInjection()),
              ),
            ],
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/edit_profil_page',
            name: 'editProfilPage',
            builder: (context, state) => EditProfilePage(),
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider.value(
            value: myInjection<ProfilBloc>(),
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
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>;
              return InfoProfilePage(
                profil: extra['profil'] as Profil,
                username: extra['username'] as String,
              );
            },
          ),
          GoRoute(
            path: '/id_card',
            name: 'IdCardPage',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>;
              return IdCardPage(
                profil: extra['profil'] as Profil,
                username: extra['username'] as String,
              );
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
      ),
      GoRoute(
        path: '/selection_language',
        name: 'selectionLanguage',
        builder: (context, state) {
          return SelectionLanguagePage();
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
        path: '/krs_page',
        name: 'krsPage',
        builder: (context, state) => BlocProvider.value(
          value: myInjection<KrsBloc>(),
          child: const KrsPage(),
        ),
      ),
      GoRoute(
        path: '/detail_krs_page',
        name: 'detailKrsPage',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final int idTahunAjaran = data['idTahunAjaran'];
          return BlocProvider.value(
            value: myInjection<KrsBloc>(),
            child: DetailKrs(idTahunAjaran: idTahunAjaran),
          );
        },
      ),
      GoRoute(
        path: 'nilai_page',
        name: 'nilaiPage',
        builder: (context, state) => const NilaiPage(),
      ),
      GoRoute(
        path: '/khs_page',
        name: 'khsPage',
        builder: (context, state) => BlocProvider.value(
          value: myInjection<KhsBloc>(),
          child: const KhsPage(),
        ),
      ),
      GoRoute(
        path: '/detail_khs_page',
        name: 'detailKhsPage',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final int semester = data['semester'];
          return BlocProvider.value(
            value: myInjection<KhsBloc>(),
            child: DetailKhs(semester: semester),
          );
        },
      ),
      GoRoute(
        path: 'transkrip_page',
        name: 'transkripPage',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => TranskripBloc(
              getTranskrip: myInjection(),
              profilLocalDataSource: myInjection(),
              loginLocalDataSource: myInjection(),
            ),
            child: TranskripPage(),
          );
        },
      ),
    ],
  );
}
