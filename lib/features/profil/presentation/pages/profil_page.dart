import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/language/l10n/app_localizations.dart';
import 'package:newsistime/features/profil/presentation/widgets/custom_menu_profil.dart';
import '../../../../core/loading/loading_manage.dart';
import '../../../../custom_widgets/text_customize.dart';
import '../../domain/entities/profil.dart';
import '../bloc/profil_bloc.dart';
import '../../../../injection.dart';
import 'package:go_router/go_router.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.profile)),

      body: BlocConsumer<ProfilBloc, ProfilState>(
        bloc: myInjection<ProfilBloc>()..add(ProfilGetMahasiswa('2244068')),
        listener: (context, state) {
          if (state is ProfilError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('error: ${state.message}'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
          if (state is ProfilLoading) {
            LoadingManager().show(context);
          } else {
            if (LoadingManager().isShowing) {
              LoadingManager().dismiss();
            }
          }
        },
        builder: (context, state) {
          if (state is ProfilLoaded) {
            Profil profil = state.detailUser;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.grey[700],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustomize(
                              text: profil.namaMahasiswa,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextCustomize(
                              text: profil.user['username'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CustomMenuProfil(
                        label: appLocalizations.infoProfil,
                        icon: Icons.edit,
                        onPressed: () {
                          context.pushNamed('infoProfilPage');
                        },
                      ),
                      CustomMenuProfil(
                        label: appLocalizations.languageSettings,
                        icon: Icons.language,
                        onPressed: () => context.pushNamed('selectionLanguage'),
                      ),
                      CustomMenuProfil(
                        label: appLocalizations.studentIdCard,
                        icon: Icons.badge,
                        onPressed: () {
                          context.pushNamed('idCard');
                        },
                      ),

                      CustomMenuProfil(
                        label: appLocalizations.changePassword,
                        icon: Icons.lock,
                      ),
                      CustomMenuProfil(label: 'Logout', icon: Icons.logout),
                    ],
                  ),
                ],
              ),
            );
          }
          // Optionally handle other states or show a fallback UI
          return SizedBox.shrink();
        },
      ),
    );
  }
}
