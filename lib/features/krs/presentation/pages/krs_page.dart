import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/localization/l10n/app_localizations.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/features/krs/domain/entities/tahun_ajaran.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/features/profil/presentation/widgets/build_info_row.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class KrsPage extends StatefulWidget {
  const KrsPage({super.key});

  @override
  State<KrsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  late KrsBloc _krsBloc;
  @override
  void initState() {
    super.initState();
    _krsBloc = context.read<KrsBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _krsBloc.add(FetchTahunAjaranKrs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<KrsBloc, KrsState>(
        listener: (context, state) {
          if (state is KrsError) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: appL10n.error,
              text: state.message,
              onConfirmBtnTap: () {
                if (state.message.contains("token")) {
                  context.goNamed("launcherPage");
                } else {
                  context.pop();
                }
              },
            );
          }
        },
        builder: (context, state) {
          if (state is KrsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is KrsLoadedTahunAjaran) {
            final listTahunAjaranAktif = state.tahunAjaranAktif;
            final listTahunAjaranTidakAktif = state.tahunAjaranTidakAktif;

            if (listTahunAjaranAktif.isEmpty &&
                listTahunAjaranTidakAktif.isEmpty) {
              return const Center(child: Text("Tidak ada data tahun ajaran."));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (listTahunAjaranAktif.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listTahunAjaranAktif.length,
                      itemBuilder: (context, index) {
                        final tahunAjaran = listTahunAjaranAktif[index];
                        return InkWell(
                          onTap: () async {
                            await context.pushNamed(
                              'detailKrsPage',
                              extra: {'idTahunAjaran': tahunAjaran.id},
                            );
                            _krsBloc.add(FetchTahunAjaranKrs());
                          },
                          child: buildTahunAjaranList(
                            context,
                            appL10n,
                            tahunAjaran,
                          ),
                        );
                      },
                    ),
                  if (listTahunAjaranTidakAktif.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listTahunAjaranTidakAktif.length,
                      itemBuilder: (context, index) {
                        final tahunAjaran = listTahunAjaranTidakAktif[index];
                        return InkWell(
                          onTap: () async {
                            await context.pushNamed(
                              'detailKrsPage',
                              extra: {'idTahunAjaran': tahunAjaran.id},
                            );
                            _krsBloc.add(FetchTahunAjaranKrs());
                          },
                          child: buildTahunAjaranList(
                            context,
                            appL10n,
                            tahunAjaran,
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildTahunAjaranList(
    BuildContext context,
    AppLocalizations appLocalizations,
    TahunAjaran tahunAjaran,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withAlpha(150)
              : Colors.black.withAlpha(150),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    BuildInfoRow(
                      label: appLocalizations.schoolYear,
                      needColon: false,
                      value: tahunAjaran.tahun.toString(),
                      labelColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      valueColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    BuildInfoRow(
                      label: appLocalizations.semester,
                      needColon: false,
                      value: tahunAjaran.semester.toString(),
                      labelColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      valueColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    BuildInfoRow(
                      label: appLocalizations.information,
                      needColon: false,
                      value: tahunAjaran.keterangan,
                      labelColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      valueColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Icon(
                  Icons.edit,
                  size: 30,
                  color: tahunAjaran.aktif ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
