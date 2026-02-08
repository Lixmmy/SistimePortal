import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/helper/date_formatter.dart';
import 'package:newsistime/custom_widgets/appbarcustom.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/presentation/widgets/build_info_row.dart';

class IdCard extends StatelessWidget {
  final String username;
  final Profil profil;
  const IdCard({super.key, required this.username, required this.profil});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    final String formattedTanggalLahir = formatDate(profil.tanggalLahir);
    return Scaffold(
      appBar: AppBarCustom(
        title: appLocalizations.identityCard,
        isShowBackButton: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade600],
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset('images/logo_stmik.png', height: 40),
                Text(
                  'STMIK TIME',
                  textAlign: TextAlign.start,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              appLocalizations.studentCard,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildInfoRow(
                        label: appLocalizations.studentIdCard,
                        value: username,
                      ),
                      BuildInfoRow(
                        label: appLocalizations.name,
                        value: profil.namaMahasiswa ?? '',
                      ),
                      BuildInfoRow(
                        label: appLocalizations.placeAndDateOfBirth,
                        value:
                            '${profil.tempatLahir ?? '-'} / $formattedTanggalLahir',
                      ),
                      BuildInfoRow(
                        label: appLocalizations.studyPrograms,
                        value: profil.programStudi?.namaProgramstudi ?? '',
                      ),
                      BuildInfoRow(
                        label: appLocalizations.validUntil,
                        value: "${profil.tahunAngkatan! + 4}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
