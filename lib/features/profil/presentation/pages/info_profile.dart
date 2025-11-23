import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/helper/date_formatter.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import '../../../../core/loading/loading_manage.dart';
import '../widgets/list_profil.dart';
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
                  final String formattedTanggalLahir = formatDate(
                    profil.tanggalLahir,
                  );
                  final String formattedTanggalIjazah = formatDate(
                    profil.tanggalIjazah,
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
                              profil.namaMahasiswa ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              profil.user.username ?? '',
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
                        subtitle: profil.programStudi?.namaProgramStudi ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.yearOfEntry,
                        subtitle: profil.tahunAngkatan.toString(),
                      ),
                      ListProfil(
                        title: appLocalizations.email,
                        subtitle: profil.email ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.campus,
                        subtitle: profil.kampus?.kodeKampus ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.placeOfBirth,
                        subtitle: profil.tempatLahir ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.dateOfBirth,
                        subtitle: formattedTanggalLahir,
                      ),
                      ListProfil(
                        title: appLocalizations.gender,
                        subtitle: (profil.jenisKelamin ?? "").isEmpty
                            ? ""
                            : profil.jenisKelamin == "P"
                            ? "Pria"
                            : "Wanita",
                      ),
                      ListProfil(
                        title: appLocalizations.religion,
                        subtitle: profil.agama?.agama ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.status,
                        subtitle: profil.status?.status ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.bloodType,
                        subtitle: profil.golonganDarah ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.nasionality,
                        subtitle: profil.kewarganegaraan ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.address,
                        subtitle: profil.alamatMahasiswa ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.noHp,
                        subtitle: profil.noTeleponMahasiswa ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.numberOfSiblings,
                        subtitle: profil.jumlahSaudara?.toString() ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.birthOrder,
                        subtitle: profil.anakKe?.toString() ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.hobby,
                        subtitle: profil.hobi ?? '',
                      ),
                      ListProfil(
                        title: appLocalizations.fatherName,
                        subtitle: profil.namaAyah ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.motherName,
                        subtitle: profil.namaIbu ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.parrentingJob,
                        subtitle: profil.pekerjaanOrangtua ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.parrentAddress,
                        subtitle: profil.alamatOrangtua ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.parentPhoneNumber,
                        subtitle: profil.noTeleponOrangtua ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.school,
                        subtitle: profil.sekolah?.namaSekolah ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.schoolDepartment,
                        subtitle: profil.jurusanSekolah ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.diplomaNumber,
                        subtitle: profil.noIjazah ?? "",
                      ),
                      ListProfil(
                        title: appLocalizations.diplomaDate,
                        subtitle: formattedTanggalIjazah,
                      ),
                      ListProfil(
                        title: appLocalizations.information,
                        subtitle: profil.keterangan ?? "",
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
