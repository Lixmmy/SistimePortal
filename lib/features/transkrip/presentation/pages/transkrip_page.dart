import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/profil/presentation/widgets/build_info_row.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';
import 'package:newsistime/features/transkrip/presentation/widgets/list_transkrip.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';

class TranskripPage extends StatefulWidget {
  const TranskripPage({super.key});

  @override
  State<TranskripPage> createState() => _TranskripPageState();
}

class _TranskripPageState extends State<TranskripPage> {
  @override
  void initState() {
    super.initState();
    // Fire the event here, once, when the widget is first created.
    myInjection<TranskripBloc>().add(const GetListTranskrip('2244068'));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<TranskripBloc, TranskripState>(
        bloc: myInjection<TranskripBloc>(),
        listener: (context, state) {
          if (state is TranskripError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('error: ${state.message}'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
          if (state is TranskripPdfDownloaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("berhasil download pdf"),
                duration: Duration(seconds: 1),
              ),
            );
            // This re-fetch is now safe and won't cause a race condition.
            myInjection<TranskripBloc>().add(const GetListTranskrip('2244068'));
          }
        },
        builder: (context, state) {
          if (state is TranskripLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TranskripLoaded) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.valueTranscript,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black.withAlpha(150),
                            ),
                          ),
                          child: Column(
                            children: [
                              BuildInfoRow(
                                label: appLocalizations.nim,
                                value: '2244068',
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
                                label: appLocalizations.name,
                                value: 'Felix',
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
                                label: appLocalizations.roomClass,
                                value: 'Ti D 22',
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
                                label: appLocalizations.studyPrograms,
                                value: 'Teknik Informatika',
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
                               color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black.withAlpha(150),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalizations.summary,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              BuildInfoRow(
                                label: appLocalizations.numberOfCoursesPassed,
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
                                label:
                                    appLocalizations.numberOfCoursesNotPassed,
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
                                label: appLocalizations.numberofCredits,
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
                                label: appLocalizations.temporaryGPA,
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
                                DownloadTranskripPdf(appLocalizations),
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
