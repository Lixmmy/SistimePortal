import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/features/home/presentation/pages/home_page.dart';
import 'package:newsistime/features/home/presentation/widgets/bnb.dart';
import 'package:newsistime/features/nilai/presentation/pages/nilai_page.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/features/profil/presentation/pages/profil_page.dart';
import 'package:quickalert/quickalert.dart';

class SelectedPage extends StatefulWidget {
  const SelectedPage({super.key});

  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfilBloc>().add(ProfilGetMahasiswa());
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const NilaiPage(),
    const ProfilPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfilBloc, ProfilState>(
        listener: (context, state) {
          if (state is ProfilLogout) {
            context.goNamed('launcherPage');
          }
          if (state is ProfilLoading) {
            LoadingManager().show(context);
          } else {
            if (LoadingManager().isShowing) {
              LoadingManager().dismiss();
            }
          }
          if (state is ProfilError) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: state.message,
              confirmBtnText: 'OK',
              onConfirmBtnTap: () {
                if (state.message.contains("Token")) {
                  context.read<ProfilBloc>().add(LogOutProfil());
                } else {
                  context.pop();
                }
              },
            );
          }
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Bnb(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
