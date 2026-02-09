import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/helper/date_formatter.dart';
import 'package:newsistime/features/agama/presentation/bloc/agama_bloc.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/features/profil/presentation/widgets/entry_form.dart';
import 'package:newsistime/features/status/presentation/bloc/status_bloc.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import 'package:quickalert/quickalert.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfilBloc>().add(ProfilGetMahasiswa());
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(appLocalizations.editProfile),
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
                        child: Text(appLocalizations.editPhoto),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EntryForm(
                            title: appLocalizations.name,
                            controller: nameController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appLocalizations.yearOfEntry,
                            controller: yearController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appLocalizations.major,
                            controller: programStudiController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appLocalizations.email,
                            controller: emailController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appLocalizations.campus,
                            controller: kampusController,
                            isReadOnly: true,
                          ),
                          EntryForm(
                            title: appLocalizations.placeOfBirth,
                            controller: placeController,
                          ),
                          EntryForm(
                            title: appLocalizations.dateOfBirth,
                            controller: dateController,
                            isDate: true,
                          ),
                          BlocBuilder<AgamaBloc, AgamaState>(
                            builder: (context, agamaState) {
                              if (agamaState is AgamaLoaded) {
                                return EntryForm(
                                  title: appLocalizations.religion,
                                  controller: religionController,
                                  isDropDown: true,
                                  dropdownItems: agamaState.agamaList
                                      .map((e) => e.name)
                                      .toList(),
                                );
                              }
                              return EntryForm(
                                title: appLocalizations.religion,
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
                                  title: appLocalizations.status,
                                  controller: statusController,
                                  isDropDown: true,
                                  dropdownItems: statusState.statusList
                                      .map((e) => e.status)
                                      .toList(),
                                );
                              }
                              return EntryForm(
                                title: appLocalizations.status,
                                controller: statusController,
                                isDropDown: true,
                                dropdownItems: [],
                              );
                            },
                          ),
                          EntryForm(
                            title: appLocalizations.bloodType,
                            controller: bloodTypeController,
                            isDropDown: true,
                            dropdownItems: bloodTypes,
                          ),
                          EntryForm(
                            title: appLocalizations.nasionality,
                            controller: nationalityController,
                          ),
                          EntryForm(
                            title: appLocalizations.address,
                            controller: addressController,
                            isLong: true,
                          ),
                          EntryForm(
                            title: appLocalizations.noHp,
                            controller: phoneNumberController,
                          ),
                          EntryForm(
                            title: appLocalizations.numberOfSiblings,
                            controller: numberOfSiblingsController,
                          ),
                          EntryForm(
                            title: appLocalizations.birthOrder,
                            controller: birthOrderController,
                          ),
                          EntryForm(
                            title: appLocalizations.hobby,
                            controller: hobbyController,
                          ),
                          EntryForm(
                            title: appLocalizations.fatherName,
                            controller: fatherNameController,
                          ),
                          EntryForm(
                            title: appLocalizations.motherName,
                            controller: motherNameController,
                          ),
                          EntryForm(
                            title: appLocalizations.parrentingJob,
                            controller: parrentingOccupationController,
                          ),
                          EntryForm(
                            title: appLocalizations.parrentAddress,
                            controller: parrentingAddressController,
                            isLong: true,
                          ),
                          EntryForm(
                            title: appLocalizations.parentPhoneNumber,
                            controller: parrentingPhoneController,
                          ),
                          EntryForm(
                            title: appLocalizations.schoolDepartment,
                            controller: schoolDepartmentController,
                          ),
                          EntryForm(
                            title: appLocalizations.diplomaNumber,
                            controller: diplomaNumberController,
                          ),
                          EntryForm(
                            title: appLocalizations.diplomaDate,
                            controller: diplomaDateController,
                            isDate: true,
                          ),
                          EntryForm(
                            title: appLocalizations.information,
                            controller: informationController,
                            isLong: true,
                          ),
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                // Gather data from controllers and original profil
                                final updatedProfil = Profil(
                                  idPendaftaran: profil.idPendaftaran,
                                  idUser: profil.idUser,
                                  // Editable fields
                                  tempatLahir: placeController.text,
                                  // tanggalLahir: dateController.text,
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
                                  // tanggalIjazah: diplomaDateController.text,
                                  keterangan: informationController.text,

                                  // Non-editable fields (from original profil)
                                  idAgama: profil.idAgama,
                                  agama: profil.agama,
                                  kodeKampus: profil.kodeKampus,
                                  kodeProgramStudi: profil.kodeProgramStudi,
                                  programStudi: profil.programStudi,
                                  namaSekolah: profil.namaSekolah,
                                  idStatus: profil.idStatus,
                                  status: profil.status,
                                  idWaktuKuliah: profil.idWaktuKuliah,
                                  waktuKuliah: profil.waktuKuliah,
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
                              child: Text(appLocalizations.save),
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
