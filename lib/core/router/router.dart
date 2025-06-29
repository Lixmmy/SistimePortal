import 'package:go_router/go_router.dart';
import 'package:newsistime/features/profil/presentation/pages/profil_page.dart';

GoRouter myRouter() {
  return GoRouter(
    initialLocation: '/profil_page',
    routes: [
      GoRoute(
        path: '/profil_page',
        name: 'profilPage',
        builder: (context, state) => ProfilPage(),
      ),
      // GoRoute(
      //   path: '/info_profil_page',
      //   name: 'infoProfilPage',
      //   builder: (context, state) => InfoProfilePage(),
      // ),
    ],
  );
}
