import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/helper/date_formatter.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/features/profil/presentation/widgets/entry_form.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
          SliverToBoxAdapter(
            child: BlocConsumer<ProfilBloc, ProfilState>(
              bloc: myInjection<ProfilBloc>()..add(ProfilGetMahasiswa()),
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
                  final TextEditingController nameController =
                      TextEditingController(text: profil.namaMahasiswa);
                  final TextEditingController yearController =
                      TextEditingController(
                        text: profil.tahunAngkatan.toString(),
                      );
                  final TextEditingController emailController =
                      TextEditingController(text: profil.email);
                  // final TextEditingController kampusController =
                  //     TextEditingController(text: profil.kampus.kodeKampus);
                  final TextEditingController placeController =
                      TextEditingController(text: profil.tempatLahir);
                  final TextEditingController religionController =
                      TextEditingController(text: profil.agama?.agama);
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
                  final TextEditingController schoolOriginController =
                      TextEditingController(text: profil.sekolah?.namaSekolah);
                  final TextEditingController schoolDepartmentController =
                      TextEditingController(text: profil.jurusanSekolah);
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
                  final List<String> religions = [
                    'Islam',
                    'Kristen',
                    'Katolik',
                    'Hindu',
                    'Buddha',
                    'Konghucu',
                  ];
                  final List<String> status = [
                    'Belum Menikah',
                    'Menikah',
                    'Duda / Janda',
                  ];
                  final List<String> bloodTypes = ['A', 'B', 'AB', 'O'];
                  return Column(
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
                            title: appLocalizations.email,
                            controller: emailController,
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
                          EntryForm(
                            title: appLocalizations.religion,
                            controller: religionController,
                            isDropDown: true,
                            dropdownItems: religions,
                          ),
                          EntryForm(
                            title: appLocalizations.status,
                            controller: statusController,
                            isDropDown: true,
                            dropdownItems: status,
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
                            title: appLocalizations.school,
                            controller: schoolOriginController,
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
                              onPressed: () {},
                              style: Theme.of(
                                context,
                              ).outlinedButtonTheme.style,
                              child: Text(appLocalizations.save),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return const Center(child: SizedBox.shrink());
              },
            ),
          ),
        ],
      ),
    );
  }
}
