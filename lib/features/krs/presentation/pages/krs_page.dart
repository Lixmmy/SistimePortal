import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/localization/l10n/app_localizations.dart';
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
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<KrsBloc, KrsState>(
      listener: (context, state) {
        if (state is KrsTokenExpired) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Session Expired",
            text: state.message,
            onConfirmBtnTap: () {
              context.goNamed('launcherPage');
            },
          );
        }
        if (state is KrsError) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "error",
            text: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is KrsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is KrsLoadedTahunAjaran) {
          final listTahunAjaranAktif = state.tahunAjaranAktif;
          // final listTahunAjaranTidakAktif = state.tahunAjaranTidakAktif;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
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
                  child: Container(
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
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    valueColor:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  BuildInfoRow(
                                    label: appLocalizations.semester,
                                    needColon: false,
                                    value: tahunAjaran.semester.toString(),
                                    labelColor:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    valueColor:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  BuildInfoRow(
                                    label: appLocalizations.information,
                                    needColon: false,
                                    value: tahunAjaran.keterangan,
                                    labelColor:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    valueColor:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
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
                                color: tahunAjaran.aktif
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
