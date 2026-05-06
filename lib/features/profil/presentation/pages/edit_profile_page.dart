import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/helper/date_formatter.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/features/agama/presentation/bloc/agama_bloc.dart';
import 'package:newsistime/features/profil/data/models/update_mahasiswa_model.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/features/profil/presentation/widgets/entry_form.dart';
import 'package:newsistime/features/status/presentation/bloc/status_bloc.dart';
import 'package:quickalert/quickalert.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfilBloc>().add(ProfilGetMahasiswa());
    context.read<AgamaBloc>().add(FetchAgamaList());
    context.read<StatusBloc>().add(FetchStatusList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(appL10n.editProfile),
            centerTitle: true,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          BlocConsumer<ProfilBloc, ProfilState>(
            listener: (context, state) {
              if (state is ProfilSuccessUpdate) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'Success',
                  text: state.message,
                ).then((_) {
                  // ignore: use_build_context_synchronously
                  context.pop();
                });
              } else if (state is ProfilError) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Error',
                  text: state.message,
                );
              }
            },
            builder: (context, state) {
              if (state is ProfilLoading) {
                return SliverFillRemaining(
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (state is ProfilLoaded) {
                Profil profil = state.detailUser;
                final TextEditingController nameController =
                    TextEditingController(text: profil.namaMahasiswa);
                final TextEditingController programStudiController =
                    TextEditingController(
                      text: profil.programStudi?.namaProgramstudi,
                    );
                final TextEditingController yearController =
                    TextEditingController(
                      text: profil.tahunAngkatan.toString(),
                    );
                final TextEditingController kampusController =
                    TextEditingController(text: profil.kodeKampus);
                final TextEditingController emailController =
                    TextEditingController(text: profil.email);
                final TextEditingController placeController =
                    TextEditingController(text: profil.tempatLahir);
                final TextEditingController religionController =
                    TextEditingController(text: profil.agama?.name);
                final TextEditingController statusController =
                    TextEditingController(text: profil.status?.status);
                final TextEditingController bloodTypeController =
                    TextEditingController(text: profil.golonganDarah ?? "");
                final TextEditingController nationalityController =
                    TextEditingController(text: profil.kewarganegaraan ?? "");
                final TextEditingController addressController =
                    TextEditingController(text: profil.alamatMahasiswa);
                final String formattedTanggalLahir = formatDate(
                  profil.tanggalLahir,
                );
                final TextEditingController phoneNumberController =
                    TextEditingController(text: profil.noTeleponMahasiswa);
                final TextEditingController numberOfSiblingsController =
                    TextEditingController(
                      text: profil.jumlahSaudara?.toString() ?? '',
                    );
                final TextEditingController birthOrderController =
                    TextEditingController(
                      text: profil.anakKe?.toString() ?? '',
                    );
                final TextEditingController hobbyController =
                    TextEditingController(text: profil.hobi ?? "");
                final TextEditingController fatherNameController =
                    TextEditingController(text: profil.namaAyah);
                final TextEditingController motherNameController =
                    TextEditingController(text: profil.namaIbu);
                final TextEditingController parrentingOccupationController =
                    TextEditingController(text: profil.pekerjaanOrangtua);
                final TextEditingController parrentingAddressController =
                    TextEditingController(text: profil.alamatOrangtua);
                final TextEditingController parrentingPhoneController =
                    TextEditingController(text: profil.noTeleponOrangtua);
                final TextEditingController schoolDepartmentController =
                    TextEditingController(text: profil.jurusan);
                final TextEditingController diplomaNumberController =
                    TextEditingController(text: profil.noIjazah);
                final String formattedTanggalIjazah = formatDate(
                  profil.tanggalIjazah,
                );
                final TextEditingController diplomaDateController =
                    TextEditingController(text: formattedTanggalIjazah);
                final TextEditingController informationController =
                    TextEditingController(text: profil.keterangan);
                final TextEditingController dateController =
                    TextEditingController(text: formattedTanggalLahir);
                final List<String> bloodTypes = ['A', 'B', 'AB', 'O'];
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ClipOval(
                        child: Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.grey[700],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(appL10n.editPhoto),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EntryForm(
                            title: appL10n.name,
                            controller: nameController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appL10n.yearOfEntry,
                            controller: yearController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appL10n.major,
                            controller: programStudiController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appL10n.email,
                            controller: emailController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appL10n.campus,
                            controller: kampusController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appL10n.placeOfBirth,
                            controller: placeController,
                          ),
                          EntryForm(
                            title: appL10n.dateOfBirth,
                            controller: dateController,
                            isDate: true,
                          ),
                          BlocBuilder<AgamaBloc, AgamaState>(
                            builder: (context, agamaState) {
                              if (agamaState is AgamaLoaded) {
                                return EntryForm(
                                  title: appL10n.religion,
                                  controller: religionController,
                                  isDropDown: true,
                                  dropdownItems: agamaState.agamaList
                                      .map((e) => e.name)
                                      .toList(),
                                );
                              }
                              return EntryForm(
                                title: appL10n.religion,
                                controller: religionController,
                                isDropDown: true,
                                dropdownItems: [],
                              );
                            },
                          ),
                          BlocBuilder<StatusBloc, StatusState>(
                            builder: (context, statusState) {
                              if (statusState is StatusLoaded) {
                                return EntryForm(
                                  title: appL10n.status,
                                  controller: statusController,
                                  isDropDown: true,
                                  dropdownItems: statusState.statusList
                                      .map((e) => e.status)
                                      .toList(),
                                );
                              }
                              return EntryForm(
                                title: appL10n.status,
                                controller: statusController,
                                isDropDown: true,
                                dropdownItems: [],
                              );
                            },
                          ),
                          EntryForm(
                            title: appL10n.bloodType,
                            controller: bloodTypeController,
                            isDropDown: true,
                            dropdownItems: bloodTypes,
                          ),
                          EntryForm(
                            title: appL10n.nasionality,
                            controller: nationalityController,
                          ),
                          EntryForm(
                            title: appL10n.address,
                            controller: addressController,
                            isLong: true,
                          ),
                          EntryForm(
                            title: appL10n.noHp,
                            controller: phoneNumberController,
                          ),
                          EntryForm(
                            title: appL10n.numberOfSiblings,
                            controller: numberOfSiblingsController,
                          ),
                          EntryForm(
                            title: appL10n.birthOrder,
                            controller: birthOrderController,
                          ),
                          EntryForm(
                            title: appL10n.hobby,
                            controller: hobbyController,
                          ),
                          EntryForm(
                            title: appL10n.fatherName,
                            controller: fatherNameController,
                          ),
                          EntryForm(
                            title: appL10n.motherName,
                            controller: motherNameController,
                          ),
                          EntryForm(
                            title: appL10n.parrentingJob,
                            controller: parrentingOccupationController,
                          ),
                          EntryForm(
                            title: appL10n.parrentAddress,
                            controller: parrentingAddressController,
                            isLong: true,
                          ),
                          EntryForm(
                            title: appL10n.parentPhoneNumber,
                            controller: parrentingPhoneController,
                          ),
                          EntryForm(
                            title: appL10n.schoolDepartment,
                            controller: schoolDepartmentController,
                          ),
                          EntryForm(
                            title: appL10n.diplomaNumber,
                            controller: diplomaNumberController,
                          ),
                          EntryForm(
                            title: appL10n.diplomaDate,
                            controller: diplomaDateController,
                            isDate: true,
                          ),
                          EntryForm(
                            title: appL10n.information,
                            controller: informationController,
                            isLong: true,
                          ),
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                final agamaState = context
                                    .read<AgamaBloc>()
                                    .state;
                                String? idAgama;
                                if (agamaState is AgamaLoaded) {
                                  try {
                                    idAgama = agamaState.agamaList
                                        .firstWhere(
                                          (element) =>
                                              element.name ==
                                              religionController.text,
                                        )
                                        .id;
                                  } catch (e) {
                                    idAgama = null;
                                  }
                                }
                                final statusState = context
                                    .read<StatusBloc>()
                                    .state;
                                int? idStatus;
                                if (statusState is StatusLoaded) {
                                  try {
                                    idStatus = statusState.statusList
                                        .firstWhere(
                                          (element) =>
                                              element.status ==
                                              statusController.text,
                                        )
                                        .idStatus;
                                  } catch (e) {
                                    idStatus = null;
                                  }
                                }
                                final updatedProfil = UpdateMahasiswaModel(
                                  tempatLahir: placeController.text,
                                  tanggalLahir: dateController.text,
                                  alamatMahasiswa: addressController.text,
                                  golonganDarah: bloodTypeController.text,
                                  kewarganegaraan: nationalityController.text,
                                  noTeleponMahasiswa:
                                      phoneNumberController.text,
                                  jumlahSaudara: int.tryParse(
                                    numberOfSiblingsController.text,
                                  ),
                                  anakKe: int.tryParse(
                                    birthOrderController.text,
                                  ),
                                  hobi: hobbyController.text,
                                  namaAyah: fatherNameController.text,
                                  namaIbu: motherNameController.text,
                                  pekerjaanOrangtua:
                                      parrentingOccupationController.text,
                                  alamatOrangtua:
                                      parrentingAddressController.text,
                                  noTeleponOrangtua:
                                      parrentingPhoneController.text,
                                  jurusan: schoolDepartmentController.text,
                                  noIjazah: diplomaNumberController.text,
                                  tanggalIjazah: diplomaDateController.text,
                                  keterangan: informationController.text,

                                  idAgama: idAgama ?? profil.idAgama,
                                  kodeKampus: profil.kodeKampus,
                                  kodeProgramStudi: profil.kodeProgramStudi,
                                  namaSekolah: profil.namaSekolah,
                                  idStatus: idStatus ?? profil.idStatus,
                                  idWaktuKuliah: profil.idWaktuKuliah,
                                  email: profil.email,
                                  namaMahasiswa: profil.namaMahasiswa,
                                  jenisKelamin: profil.jenisKelamin,
                                  tahunAngkatan: profil.tahunAngkatan,
                                  pendidikanOrangtua: profil.pendidikanOrangtua,
                                  tanggalPendaftaran: profil.tanggalPendaftaran,
                                  tahunLulus: profil.tahunLulus,
                                );

                                context.read<ProfilBloc>().add(
                                  ProfilUpdateMahasiswa(
                                    idUser: profil.idUser.toString(),
                                    updateProfil: updatedProfil,
                                  ),
                                );
                              },
                              style: Theme.of(
                                context,
                              ).outlinedButtonTheme.style,
                              child: Text(appL10n.save),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
