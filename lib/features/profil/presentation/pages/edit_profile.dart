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
                  final TextEditingController nameController =
                      TextEditingController(text: profil.namaMahasiswa);
                  final TextEditingController yearController =
                      TextEditingController(
                        text: profil.tahunAngkatan.toString(),
                      );
                  final TextEditingController emailController =
                      TextEditingController(text: profil.email);
                  final TextEditingController placeController =
                      TextEditingController(text: profil.tempatLahir);
                  final TextEditingController religionController =
                      TextEditingController(text: profil.agama.agama!);
                  final String formattedTanggalLahir = formatDate(
                    profil.tanggalLahir,
                  );
                  // final String formattedTanggalIjazah = formatDate(
                  //   profil.tanggalIjazah,
                  // );
                  final TextEditingController dateController =
                      TextEditingController(text: formattedTanggalLahir);
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
                          ),
                          EntryForm(
                            title: appLocalizations.religion,
                            controller: religionController,
                            isDropDown: true,
                          ),
                          EntryForm(
                            title: appLocalizations.yearOfEntry,
                            controller: yearController,
                          ),
                          EntryForm(
                            title: appLocalizations.email,
                            controller: emailController,
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
