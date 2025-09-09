import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import '../../../../core/loading/loading_manage.dart';
import '../widgets/list_profil.dart';
import '../../../../custom_widgets/text_customize.dart';
import '../../domain/entities/profil.dart';
import '../bloc/profil_bloc.dart';
import '../../../../injection.dart';

class InfoProfilePage extends StatefulWidget {
  const InfoProfilePage({super.key});

  @override
  State<InfoProfilePage> createState() => _InfoProfilePageState();
}

class _InfoProfilePageState extends State<InfoProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.primaryColorA0,
            title: Text(appLocalizations.infoProfil),
            centerTitle: true,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<ProfilBloc, ProfilState>(
              bloc: myInjection<ProfilBloc>()
                ..add(ProfilGetMahasiswa('2244068')),
              listener: (context, state) {
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
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 95, 189, 252),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            ClipOval(
                              child: Icon(
                                Icons.account_circle,
                                size: 100,
                                color: Colors.grey[700],
                              ),
                            ),
                            TextCustomize(
                              text: profil.namaMahasiswa,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            TextCustomize(
                              text: profil.user.username,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      ListProfil(
                        title: appLocalizations.email,
                        subtitle: profil.email,
                      ),
                      ListProfil(
                        title: appLocalizations.major,
                        subtitle: profil.programStudi.namaProgramStudi!,
                      ),
                      ListProfil(
                        title: appLocalizations.yearOfEntry,
                        subtitle: profil.tahunAngkatan.toString(),
                      ),
                      ListProfil(
                        title: appLocalizations.religion,
                        subtitle: profil.agama.agama!,
                      ),
                      ListProfil(
                        title: appLocalizations.noHp,
                        subtitle: profil.noTeleponMahasiswa.toString(),
                      ),
                      SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {
                          context.pushNamed('editProfilPage');
                        },
                        style: Theme.of(context).outlinedButtonTheme.style,
                        child: TextCustomize(
                          text: appLocalizations.editProfile,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: SizedBox.shrink());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
