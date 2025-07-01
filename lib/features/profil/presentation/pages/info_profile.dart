import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/custom_widgets/list_profil.dart';
import 'package:newsistime/custom_widgets/text_customize.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/injection.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Info Profil'),
        leading: IconButton(
          onPressed: () {
            context.goNamed('profilPage');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<ProfilBloc, ProfilState>(
        bloc: myInjection<ProfilBloc>()..add(ProfilGetMahasiswa('2244068')),
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextCustomize(
                        text: profil.user['username'],
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
                ListProfil(title: 'Email', subtitle: profil.email),
                ListProfil(
                  title: 'Jurusan',
                  subtitle: profil.programStudi['namaProgramstudi'],
                ),
                ListProfil(
                  title: 'Angkatan',
                  subtitle: profil.tahunAngkatan.toString(),
                ),
                ListProfil(title: 'Agama', subtitle: profil.agama['agama']),
                ListProfil(
                  title: 'No.Hp',
                  subtitle: profil.noTeleponMahasiswa.toString(),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {},
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: TextCustomize(text: 'Edit Profil'),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Failed to load profile data'));
          }
        },
      ),
    );
  }
}
