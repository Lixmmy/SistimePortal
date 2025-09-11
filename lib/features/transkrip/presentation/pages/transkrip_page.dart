import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/features/profil/presentation/widgets/build_info_row.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';
import 'package:newsistime/features/transkrip/presentation/widgets/list_transkrip.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';

import 'package:newsistime/features/transkrip/domain/function/grade_converter.dart';

class TranskripPage extends StatefulWidget {
  const TranskripPage({super.key});

  @override
  State<TranskripPage> createState() => _TranskripPageState();
}

class _TranskripPageState extends State<TranskripPage> {
  double _getBobot(String letterGrade) {
    switch (letterGrade) {
      case 'A':
        return 4.0;
      case 'B':
        return 3.0;
      case 'C':
        return 2.0;
      case 'D':
        return 1.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocConsumer(
              bloc: myInjection<TranskripBloc>()
                ..add(const GetListTranskrip('2244068')),
              listener: (context, state) {
                if (state is TranskripError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('error: ${state.message}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                if (state is TranskripLoading) {
                  LoadingManager().show(context);
                } else {
                  if (LoadingManager().isShowing) {
                    LoadingManager().dismiss();
                  }
                }
              },
              builder: (context, state) {
                if (state is TranskripLoaded) {
                  int passedCourses = 0;
                  int failedCourses = 0;
                  int totalSks = 0;
                  double totalBobot = 0;

                  for (var transkrip in state.listTranskrip) {
                    final nilai = transkrip.nilai;
                    totalSks += transkrip.sks;
                    if (nilai != null) {
                      final List<double> scores = [
                        nilai.tugas,
                        nilai.uts,
                        nilai.uas,
                        nilai.absensi,
                        nilai.project ?? 0,
                        nilai.quiz ?? 0,
                      ];
                      if (scores.isNotEmpty) {
                        final double averageScore =
                            scores.reduce((a, b) => a + b) /
                            (nilai.project == 0 ? scores.length : 4);
                        final letterGrade = konversiNilaiKeHuruf(averageScore);
                        if (letterGrade == 'A' ||
                            letterGrade == 'B' ||
                            letterGrade == 'C') {
                          passedCourses++;
                        } else {
                          failedCourses++;
                        }
                        totalBobot += _getBobot(letterGrade) * transkrip.sks;
                      }
                    }
                  }

                  final double gpa = totalSks > 0 ? totalBobot / totalSks : 0;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.transcripts,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black.withAlpha(150),
                            ),
                          ),
                          child: Column(
                            children: [
                              BuildInfoRow(
                                label: appLocalizations.nim,
                                value: '2244068',
                                valueFlex: 6,
                                labelFlex: 3,
                                labelColor: Colors.black,
                                valueColor: Colors.black,
                              ),
                              BuildInfoRow(
                                label: appLocalizations.name,
                                value: 'Felix',
                                valueFlex: 6,
                                labelFlex: 3,
                                labelColor: Colors.black,
                                valueColor: Colors.black,
                              ),
                              BuildInfoRow(
                                label: appLocalizations.roomClass,
                                value: 'Ti D 22',
                                valueFlex: 6,
                                labelFlex: 3,
                                labelColor: Colors.black,
                                valueColor: Colors.black,
                              ),
                              BuildInfoRow(
                                label: appLocalizations.studyPrograms,
                                value: 'Teknik Informatika',
                                valueFlex: 6,
                                labelFlex: 3,
                                labelColor: Colors.black,
                                valueColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        ListTranskrip(state: state),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black.withAlpha(150),
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
                                value: passedCourses.toString(),
                                valueFlex: 3,
                                labelFlex: 6,
                                labelColor: Colors.black,
                                valueColor: Colors.black,
                              ),
                              BuildInfoRow(
                                label:
                                    appLocalizations.numberOfCoursesNotPassed,
                                value: failedCourses.toString(),
                                valueFlex: 3,
                                labelFlex: 6,
                                labelColor: Colors.black,
                                valueColor: Colors.black,
                              ),
                              BuildInfoRow(
                                label: appLocalizations.numberofCredits,
                                value: totalSks.toString(),
                                valueFlex: 3,
                                labelFlex: 6,
                                labelColor: Colors.black,
                                valueColor: Colors.black,
                              ),
                              BuildInfoRow(
                                label: appLocalizations.temporaryGPA,
                                value: gpa.toStringAsFixed(2),
                                valueFlex: 3,
                                labelFlex: 6,
                                labelColor: Colors.black,
                                valueColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<TranskripBloc>().add(
                                const DownloadTranskripPdf(),
                              );
                            },
                            child: Text("Download PDF"),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
