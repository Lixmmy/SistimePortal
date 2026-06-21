import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sistime_portal/core/helper/date_formatter.dart';
import 'package:sistime_portal/custom_widgets/appbarcustom.dart';
import 'package:sistime_portal/core/localization/localization_service.dart';
import 'package:sistime_portal/features/profil/domain/entities/profil.dart';
import 'package:sistime_portal/features/profil/presentation/widgets/build_info_row.dart';

class IdCardPage extends StatelessWidget {
  final String username;
  final Profil profil;
  const IdCardPage({super.key, required this.username, required this.profil});

  @override
  Widget build(BuildContext context) {
    final String formattedTanggalLahir = formatDate(profil.tanggalLahir);
    return Scaffold(
      appBar: AppBarCustom(
        title: appL10n.identityCard,
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
              appL10n.studentCard,
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
                        label: appL10n.studentIdCard,
                        value: username,
                      ),
                      BuildInfoRow(
                        label: appL10n.name,
                        value: profil.namaMahasiswa ?? '',
                      ),
                      BuildInfoRow(
                        label: appL10n.placeAndDateOfBirth,
                        value:
                            '${profil.tempatLahir ?? '-'} / $formattedTanggalLahir',
                      ),
                      BuildInfoRow(
                        label: appL10n.studyPrograms,
                        value: profil.programStudi?.namaProgramstudi ?? '',
                      ),
                      BuildInfoRow(
                        label: appL10n.validUntil,
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
