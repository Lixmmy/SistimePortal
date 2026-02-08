import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/helper/date_formatter.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import '../widgets/list_profil.dart';
import '../../domain/entities/profil.dart';

class InfoProfilePage extends StatefulWidget {
  final Profil profil;
  final String username;
  const InfoProfilePage({
    super.key,
    required this.profil,
    required this.username,
  });

  @override
  State<InfoProfilePage> createState() => _InfoProfilePageState();
}

class _InfoProfilePageState extends State<InfoProfilePage> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String formattedTanggalLahir = formatDate(widget.profil.tanggalLahir);
    final String formattedTanggalIjazah = formatDate(
      widget.profil.tanggalIjazah,
    );
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
            child: Column(
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
                      Text(
                        widget.profil.namaMahasiswa ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                ListProfil(
                  title: appLocalizations.major,
                  subtitle: widget.profil.programStudi?.namaProgramstudi ?? "",
                ),
                ListProfil(
                  title: appLocalizations.yearOfEntry,
                  subtitle: widget.profil.tahunAngkatan.toString(),
                ),
                ListProfil(
                  title: appLocalizations.email,
                  subtitle: widget.profil.email ?? "",
                ),
                ListProfil(
                  title: appLocalizations.campus,
                  subtitle: widget.profil.kodeKampus ?? "",
                ),
                ListProfil(
                  title: appLocalizations.placeOfBirth,
                  subtitle: widget.profil.tempatLahir ?? "",
                ),
                ListProfil(
                  title: appLocalizations.dateOfBirth,
                  subtitle: formattedTanggalLahir,
                ),
                ListProfil(
                  title: appLocalizations.gender,
                  subtitle: (widget.profil.jenisKelamin ?? "").isEmpty
                      ? ""
                      : widget.profil.jenisKelamin == "P"
                      ? "Pria"
                      : "Wanita",
                ),

                ListProfil(
                  title: appLocalizations.religion,
                  subtitle: widget.profil.agama?.name ?? "",
                ),

                ListProfil(
                  title: appLocalizations.status,
                  subtitle: widget.profil.status?.status ?? "",
                ),
                ListProfil(
                  title: appLocalizations.bloodType,
                  subtitle: widget.profil.golonganDarah ?? "",
                ),
                ListProfil(
                  title: appLocalizations.nasionality,
                  subtitle: widget.profil.kewarganegaraan ?? "",
                ),
                ListProfil(
                  title: appLocalizations.address,
                  subtitle: widget.profil.alamatMahasiswa ?? "",
                ),
                ListProfil(
                  title: appLocalizations.noHp,
                  subtitle: widget.profil.noTeleponMahasiswa ?? "",
                ),
                ListProfil(
                  title: appLocalizations.numberOfSiblings,
                  subtitle: widget.profil.jumlahSaudara?.toString() ?? "",
                ),
                ListProfil(
                  title: appLocalizations.birthOrder,
                  subtitle: widget.profil.anakKe?.toString() ?? "",
                ),
                ListProfil(
                  title: appLocalizations.hobby,
                  subtitle: widget.profil.hobi ?? '',
                ),
                ListProfil(
                  title: appLocalizations.fatherName,
                  subtitle: widget.profil.namaAyah ?? "",
                ),
                ListProfil(
                  title: appLocalizations.motherName,
                  subtitle: widget.profil.namaIbu ?? "",
                ),
                ListProfil(
                  title: appLocalizations.parrentingJob,
                  subtitle: widget.profil.pekerjaanOrangtua ?? "",
                ),
                ListProfil(
                  title: appLocalizations.parrentAddress,
                  subtitle: widget.profil.alamatOrangtua ?? "",
                ),
                ListProfil(
                  title: appLocalizations.parentPhoneNumber,
                  subtitle: widget.profil.noTeleponOrangtua ?? "",
                ),
                // ListProfil(
                //   title: appLocalizations.school,
                //   subtitle: profil.sekolah?.namaSekolah ?? "",
                // ),
                ListProfil(
                  title: appLocalizations.schoolDepartment,
                  subtitle: widget.profil.jurusan ?? "",
                ),
                ListProfil(
                  title: appLocalizations.diplomaNumber,
                  subtitle: widget.profil.noIjazah ?? "",
                ),
                ListProfil(
                  title: appLocalizations.diplomaDate,
                  subtitle: formattedTanggalIjazah,
                ),
                ListProfil(
                  title: appLocalizations.information,
                  subtitle: widget.profil.keterangan ?? "",
                ),

                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    context.pushNamed('editProfilPage');
                  },
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: Text(appLocalizations.editProfile),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
