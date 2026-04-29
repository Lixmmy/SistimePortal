import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/features/profil/presentation/widgets/build_info_row.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';
import 'package:newsistime/features/transkrip/presentation/widgets/list_transkrip.dart';
import 'package:newsistime/injection.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TranskripPage extends StatefulWidget {
  const TranskripPage({super.key});

  @override
  State<TranskripPage> createState() => _TranskripPageState();
}

class _TranskripPageState extends State<TranskripPage> {
  @override
  void initState() {
    super.initState();
    myInjection<TranskripBloc>().add(GetListTranskrip());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TranskripBloc, TranskripState>(
        bloc: myInjection<TranskripBloc>(),
        listener: (context, state) {
          if (state is TranskripError) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: appL10n.error,
              text: state.message,
              onConfirmBtnTap: () {
                if (state.message.toLowerCase().contains("token")) {
                  context.goNamed("launcherPage");
                } else {
                  context.pop();
                }
              },
            );
          }
          if (state is TranskripTokenExpired) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: appL10n.tokenExpired,
              text: state.message,
              onConfirmBtnTap: () {
                context.goNamed("launcherPage");
              },
            );
          }
          if (state is TranskripPdfDownloaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("berhasil download pdf"),
                duration: Duration(seconds: 1),
              ),
            );
            myInjection<TranskripBloc>().add(GetListTranskrip());
          }
        },
        builder: (context, state) {
          if (state is TranskripLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TranskripLoaded) {
            final profil = state.profil;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appL10n.valueTranscript,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black.withAlpha(150),
                            ),
                          ),
                          child: Column(
                            children: [
                              BuildInfoRow(
                                label: appL10n.nim,
                                value: state.username,
                                valueFlex: 6,
                                labelFlex: 3,
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
                                label: appL10n.name,
                                value: profil.namaMahasiswa,
                                valueFlex: 6,
                                labelFlex: 3,
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
                                label: appL10n.roomClass,
                                value: profil.statusMahasiswa!.kodeKelas,
                                valueFlex: 6,
                                labelFlex: 3,
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
                                label: appL10n.studyPrograms,
                                value:
                                    profil.programStudi?.namaProgramstudi ?? '',
                                valueFlex: 6,
                                labelFlex: 3,
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
                        ListTranskrip(state: state),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black.withAlpha(150),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appL10n.summary,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              BuildInfoRow(
                                label: appL10n.numberOfCoursesPassed,
                                value: state.passedCourses.toString(),
                                valueFlex: 3,
                                labelFlex: 6,
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
                                label: appL10n.numberOfCoursesNotPassed,
                                value: state.failedCourses.toString(),
                                valueFlex: 3,
                                labelFlex: 6,
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
                                label: appL10n.numberofCredits,
                                value: state.totalSks.toString(),
                                valueFlex: 3,
                                labelFlex: 6,
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
                                label: appL10n.temporaryGPA,
                                value: state.gpa.toStringAsFixed(2),
                                valueFlex: 3,
                                labelFlex: 6,
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
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              myInjection<TranskripBloc>().add(
                                DownloadTranskripPdf(appL10n),
                              );
                            },
                            child: Text("Download PDF"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
