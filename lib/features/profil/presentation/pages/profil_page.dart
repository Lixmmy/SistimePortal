import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/custom_widgets/custom_menu_profil.dart';
import 'package:newsistime/custom_widgets/text_customize.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsistime/injection.dart';

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
    return BlocConsumer<ProfilBloc, ProfilState>(
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
      },
      builder: (context, state) {
        if (state is ProfilLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ProfilLoaded) {
          Profil profil = state.detailUser;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 95, 189, 252),
              title: Text(
                'Info Profil',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
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
                        label: 'Info Profile',
                        icon: Icons.edit,
                        // onPressed: () => context.goNamed('infoProfilPage'),
                      ),
                      CustomMenuProfil(label: 'Bahasa', icon: Icons.language),
                      CustomMenuProfil(
                        label: 'Kartu Tanda Mahasiswa',
                        icon: Icons.badge,
                      ),

                      CustomMenuProfil(
                        label: 'Ganti Password',
                        icon: Icons.lock,
                      ),
                      CustomMenuProfil(label: 'Logout', icon: Icons.logout),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        // Optionally handle other states or show a fallback UI
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: Text('Data profil tidak tersedia')),
        );
      },
    );
  }
}
