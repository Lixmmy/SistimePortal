import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/features/language/l10n/app_localizations.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/features/profil/presentation/widgets/build_info_row.dart';
import 'package:newsistime/injection.dart';

class IdCard extends StatelessWidget {
  const IdCard({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.identityCard),
        leading: IconButton(
          onPressed: () {
            context.pop();
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
            final DateTime? tanggalLahir = profil.tanggalLahir != null
                ? DateTime.fromMillisecondsSinceEpoch(profil.tanggalLahir!)
                : null;
            final String formattedTanggalLahir = DateFormat(
              'dd MMMM yyyy',
              'id_ID',
            ).format(tanggalLahir!);
            return Card(
              elevation: 4.0, // Gives a shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
              ),
              margin: EdgeInsets.all(20.0), // Margin around the card
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  // This is where you'd set the gradient background seen in the image
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade600,
                    ], // Example colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('images/logo_stmik.png', height: 60),
                        Expanded(
                          child: Text(
                            'STMIK\nTIME',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w900,

                              height: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      appLocalizations.studentCard,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildInfoRow(
                                label: appLocalizations.studentIdCard,
                                value: profil.user['username'],
                              ),
                              BuildInfoRow(
                                label: appLocalizations.name,
                                value: profil.namaMahasiswa,
                              ),
                              BuildInfoRow(
                                label: appLocalizations.placeAndDateOfBirth,
                                value:
                                    '${profil.tempatLahir}/ $formattedTanggalLahir',
                              ),
                              BuildInfoRow(
                                label: appLocalizations.studyPrograms,
                                value: profil.programStudi['namaProgramstudi'],
                              ),
                              BuildInfoRow(
                                label: appLocalizations.validUntil,
                                value: "${profil.tahunAngkatan! + 4}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/felix_profile.jpg',
                            ), // Add Felix's picture
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Failed to load profile data'));
          }
        },
      ),
    );
  }
}
