import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/helper/date_formatter.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/core/theme/theme.dart';
import '../widgets/list_profil.dart';
import '../../domain/entities/profil.dart';
import '../bloc/profil_bloc.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTanggalLahir = formatDate(widget.profil.tanggalLahir);
    final String formattedTanggalIjazah = formatDate(
      widget.profil.tanggalIjazah,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.primaryColorA0,
            title: Text(appL10n.infoProfil),
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
                  final profilFromState = state.profil;
                  final formattedTanggalLahir = formatDate(
                    profilFromState.tanggalLahir,
                  );
                  final formattedTanggalIjazah = formatDate(
                    profilFromState.tanggalIjazah,
                  );
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
                            Text(
                              profilFromState.namaMahasiswa ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              state.username,
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
                        title: appL10n.major,
                        subtitle:
                            profilFromState.programStudi?.namaProgramstudi ??
                            "",
                      ),
                      ListProfil(
                        title: appL10n.yearOfEntry,
                        subtitle: profilFromState.tahunAngkatan.toString(),
                      ),
                      ListProfil(
                        title: appL10n.email,
                        subtitle: profilFromState.email ?? "",
                      ),
                      ListProfil(
                        title: appL10n.campus,
                        subtitle: profilFromState.kodeKampus ?? "",
                      ),
                      ListProfil(
                        title: appL10n.placeOfBirth,
                        subtitle: profilFromState.tempatLahir ?? "",
                      ),
                      ListProfil(
                        title: appL10n.dateOfBirth,
                        subtitle: formattedTanggalLahir,
                      ),
                      ListProfil(
                        title: appL10n.gender,
                        subtitle: (profilFromState.jenisKelamin ?? "").isEmpty
                            ? ""
                            : profilFromState.jenisKelamin == "P"
                            ? "Pria"
                            : "Wanita",
                      ),

                      ListProfil(
                        title: appL10n.religion,
                        subtitle: profilFromState.agama?.name ?? "",
                      ),

                      ListProfil(
                        title: appL10n.status,
                        subtitle: profilFromState.status?.status ?? "",
                      ),
                      ListProfil(
                        title: appL10n.bloodType,
                        subtitle: profilFromState.golonganDarah ?? "",
                      ),
                      ListProfil(
                        title: appL10n.nasionality,
                        subtitle: profilFromState.kewarganegaraan ?? "",
                      ),
                      ListProfil(
                        title: appL10n.address,
                        subtitle: profilFromState.alamatMahasiswa ?? "",
                      ),
                      ListProfil(
                        title: appL10n.noHp,
                        subtitle: profilFromState.noTeleponMahasiswa ?? "",
                      ),
                      ListProfil(
                        title: appL10n.numberOfSiblings,
                        subtitle:
                            profilFromState.jumlahSaudara?.toString() ?? "",
                      ),
                      ListProfil(
                        title: appL10n.birthOrder,
                        subtitle: profilFromState.anakKe?.toString() ?? "",
                      ),
                      ListProfil(
                        title: appL10n.hobby,
                        subtitle: profilFromState.hobi ?? '',
                      ),
                      ListProfil(
                        title: appL10n.fatherName,
                        subtitle: profilFromState.namaAyah ?? "",
                      ),
                      ListProfil(
                        title: appL10n.motherName,
                        subtitle: profilFromState.namaIbu ?? "",
                      ),
                      ListProfil(
                        title: appL10n.parrentingJob,
                        subtitle: profilFromState.pekerjaanOrangtua ?? "",
                      ),
                      ListProfil(
                        title: appL10n.parrentAddress,
                        subtitle: profilFromState.alamatOrangtua ?? "",
                      ),
                      ListProfil(
                        title: appL10n.parentPhoneNumber,
                        subtitle: profilFromState.noTeleponOrangtua ?? "",
                      ),
                      // ListProfil(
                      //   title: appLocalizations.school,
                      //   subtitle: profil.sekolah?.namaSekolah ?? "",
                      // ),
                      ListProfil(
                        title: appL10n.schoolDepartment,
                        subtitle: profilFromState.jurusan ?? "",
                      ),
                      ListProfil(
                        title: appL10n.diplomaNumber,
                        subtitle: profilFromState.noIjazah ?? "",
                      ),
                      ListProfil(
                        title: appL10n.diplomaDate,
                        subtitle: formattedTanggalIjazah,
                      ),
                      ListProfil(
                        title: appL10n.information,
                        subtitle: profilFromState.keterangan ?? "",
                      ),

                      SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {
                          context.pushNamed('editProfilPage');
                        },
                        style: Theme.of(context).outlinedButtonTheme.style,
                        child: Text(appL10n.editProfile),
                      ),
                    ],
                  );
                } else {
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
                            Text(
                              widget.profil.namaMahasiswa ?? "",
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
                        title: appL10n.major,
                        subtitle:
                            widget.profil.programStudi?.namaProgramstudi ?? "",
                      ),
                      ListProfil(
                        title: appL10n.yearOfEntry,
                        subtitle: widget.profil.tahunAngkatan.toString(),
                      ),
                      ListProfil(
                        title: appL10n.email,
                        subtitle: widget.profil.email ?? "",
                      ),
                      ListProfil(
                        title: appL10n.campus,
                        subtitle: widget.profil.kodeKampus ?? "",
                      ),
                      ListProfil(
                        title: appL10n.placeOfBirth,
                        subtitle: widget.profil.tempatLahir ?? "",
                      ),
                      ListProfil(
                        title: appL10n.dateOfBirth,
                        subtitle: formattedTanggalLahir,
                      ),
                      ListProfil(
                        title: appL10n.gender,
                        subtitle: (widget.profil.jenisKelamin ?? "").isEmpty
                            ? ""
                            : widget.profil.jenisKelamin == "P"
                            ? appL10n.male
                            : appL10n.female,
                      ),

                      ListProfil(
                        title: appL10n.religion,
                        subtitle: widget.profil.agama?.name ?? "",
                      ),

                      ListProfil(
                        title: appL10n.status,
                        subtitle: widget.profil.status?.status ?? "",
                      ),
                      ListProfil(
                        title: appL10n.bloodType,
                        subtitle: widget.profil.golonganDarah ?? "",
                      ),
                      ListProfil(
                        title: appL10n.nasionality,
                        subtitle: widget.profil.kewarganegaraan ?? "",
                      ),
                      ListProfil(
                        title: appL10n.address,
                        subtitle: widget.profil.alamatMahasiswa ?? "",
                      ),
                      ListProfil(
                        title: appL10n.noHp,
                        subtitle: widget.profil.noTeleponMahasiswa ?? "",
                      ),
                      ListProfil(
                        title: appL10n.numberOfSiblings,
                        subtitle: widget.profil.jumlahSaudara?.toString() ?? "",
                      ),
                      ListProfil(
                        title: appL10n.birthOrder,
                        subtitle: widget.profil.anakKe?.toString() ?? "",
                      ),
                      ListProfil(
                        title: appL10n.hobby,
                        subtitle: widget.profil.hobi ?? '',
                      ),
                      ListProfil(
                        title: appL10n.fatherName,
                        subtitle: widget.profil.namaAyah ?? "",
                      ),
                      ListProfil(
                        title: appL10n.motherName,
                        subtitle: widget.profil.namaIbu ?? "",
                      ),
                      ListProfil(
                        title: appL10n.parrentingJob,
                        subtitle: widget.profil.pekerjaanOrangtua ?? "",
                      ),
                      ListProfil(
                        title: appL10n.parrentAddress,
                        subtitle: widget.profil.alamatOrangtua ?? "",
                      ),
                      ListProfil(
                        title: appL10n.parentPhoneNumber,
                        subtitle: widget.profil.noTeleponOrangtua ?? "",
                      ),
                      // ListProfil(
                      //   title: appLocalizations.school,
                      //   subtitle: profil.sekolah?.namaSekolah ?? "",
                      // ),
                      ListProfil(
                        title: appL10n.schoolDepartment,
                        subtitle: widget.profil.jurusan ?? "",
                      ),
                      ListProfil(
                        title: appL10n.diplomaNumber,
                        subtitle: widget.profil.noIjazah ?? "",
                      ),
                      ListProfil(
                        title: appL10n.diplomaDate,
                        subtitle: formattedTanggalIjazah,
                      ),
                      ListProfil(
                        title: appL10n.information,
                        subtitle: widget.profil.keterangan ?? "",
                      ),

                      SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {
                          context.pushNamed('editProfilPage');
                        },
                        style: Theme.of(context).outlinedButtonTheme.style,
                        child: Text(appL10n.editProfile),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
