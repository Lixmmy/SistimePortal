import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/features/profil/presentation/widgets/custom_menu_profil.dart';
import 'package:quickalert/quickalert.dart';
import '../../domain/entities/profil.dart';
import '../bloc/profil_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfilBloc>().add(ProfilGetMahasiswa());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(appL10n.profile),
            centerTitle: true,
            floating: true,
          ),
          BlocConsumer<ProfilBloc, ProfilState>(
            listener: (context, state) {
              if (state is ProfilError) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: appL10n.error,
                  text: state.message,
                );
              } else if (state is ProfilTokenExpired) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: appL10n.tokenExpired,
                  text: state.message,
                  onConfirmBtnTap: () {
                    context.goNamed('launcherPage');
                  },
                );
              } else if (state is ProfilLogout) {
                context.goNamed('launcherPage');
              }
            },
            builder: (context, state) {
              if (state is ProfilLoading) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              }
              if (state is ProfilLoaded) {
                Profil profil = state.detailUser;
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                  Text(
                                    profil.namaMahasiswa!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    state.username,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            CustomMenuProfil(
                              label: appL10n.infoProfil,
                              icon: Icons.edit,
                              onPressed: () {
                                context.pushNamed(
                                  'infoProfilPage',
                                  extra: {
                                    'profil': profil,
                                    'username': state.username,
                                  },
                                );
                              },
                            ),
                            CustomMenuProfil(
                              label: appL10n.languageSettings,
                              icon: Icons.language,
                              onPressed: () =>
                                  context.pushNamed('selectionLanguage'),
                            ),
                            CustomMenuProfil(
                              label: appL10n.studentIdCard,
                              icon: Icons.badge,
                              onPressed: () {
                                context.pushNamed(
                                  'idCard',
                                  extra: {
                                    'profil': profil,
                                    'username': state.username,
                                  },
                                );
                              },
                            ),
                            CustomMenuProfil(
                              label: appL10n.changePassword,
                              icon: Icons.lock,
                              onPressed: () {
                                context.pushNamed('changePasswordPage');
                              },
                            ),
                            CustomMenuProfil(
                              label: 'Logout',
                              icon: Icons.logout,
                              onPressed: () {
                                context.read<ProfilBloc>().add(LogOutProfil());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
