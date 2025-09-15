import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import 'package:newsistime/features/profil/presentation/widgets/build_info_row.dart';

class DetailKhs extends StatefulWidget {
  const DetailKhs({super.key, required this.semester});
  final int semester;

  @override
  State<DetailKhs> createState() => _DetailKrsState();
}

class _DetailKrsState extends State<DetailKhs> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocListener<KhsBloc, KhsState>(
        bloc: myInjection<KhsBloc>(),
        listener: (context, state) {
          if (state is KhsPdfDownloaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("berhasil download pdf"),
                duration: Duration(seconds: 1),
              ),
            );
            myInjection<KhsBloc>().add(const FetchKhsData(nim: '2244068'));
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Image.asset(
                        'images/logo_stmik.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: 8),
                    ), // Spacing between logo and text
                    TextSpan(
                      text: 'STMIK',
                      style: Theme.of(context).appBarTheme.titleTextStyle
                          ?.copyWith(fontWeight: FontWeight.w200),
                    ),
                    TextSpan(
                      text: ' TIME',
                      style: Theme.of(context).appBarTheme.titleTextStyle
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              pinned: true,
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            BlocBuilder<KhsBloc, KhsState>(
              bloc: myInjection<KhsBloc>(),
              builder: (context, state) {
                if (state is KhsLoaded) {
                  final khs = state.groupedKhs[widget.semester]!;
                  return SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            appLocalizations.studyResultsCard,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                                BuildInfoRow(
                                  label: appLocalizations.semester,
                                  value: widget.semester.toString(),
                                  valueFlex: 6,
                                  labelFlex: 3,
                                  labelColor: Colors.black,
                                  valueColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final khsItem = khs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black.withAlpha(150),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    khsItem.matkul,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                  Text(
                                    '${appLocalizations.code}: ${khsItem.kodeMatkul} | ${appLocalizations.sks}: ${khsItem.sks}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BuildInfoRow(
                                              label: appLocalizations
                                                  .attendanceGrade,
                                              value: khsItem.nilai!.absensi
                                                  .toString(),
                                              valueColor:
                                                  AppTheme.primaryColorA0,
                                              labelColor: Colors.black,
                                            ),
                                            if (khsItem.nilai?.quiz != null)
                                              BuildInfoRow(
                                                label:
                                                    appLocalizations.quizGrade,
                                                value: khsItem.nilai!.quiz
                                                    .toString(),
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                                labelColor: Colors.black,
                                              ),
                                            BuildInfoRow(
                                              label: appLocalizations
                                                  .assignmentGrade,
                                              value: khsItem.nilai!.tugas
                                                  .toString(),
                                              valueColor:
                                                  AppTheme.primaryColorA0,
                                              labelColor: Colors.black,
                                            ),
                                            if (khsItem.nilai?.project != null)
                                              BuildInfoRow(
                                                label: appLocalizations
                                                    .projectScore,
                                                value: khsItem.nilai!.project
                                                    .toString(),
                                                labelColor: Colors.black,
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                              ),
                                            BuildInfoRow(
                                              label:
                                                  appLocalizations.midTermGrade,
                                              value: khsItem.nilai!.uts
                                                  .toString(),
                                              valueColor:
                                                  AppTheme.primaryColorA0,
                                              labelColor: Colors.black,
                                            ),
                                            BuildInfoRow(
                                              label:
                                                  appLocalizations.finalGrade,
                                              value: khsItem.nilai!.uas
                                                  .toString(),
                                              valueColor:
                                                  AppTheme.primaryColorA0,
                                              labelColor: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          khsItem.letterGrade ?? 'N/A',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                                color: getGradeColor(
                                                  khsItem.letterGrade ?? 'N/A',
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }, childCount: khs.length),
                      ),
                      SliverToBoxAdapter(
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              myInjection<KhsBloc>().add(
                                DownloadKhsPdf(
                                  appLocalizations: appLocalizations,
                                  semester: widget.semester,
                                ),
                              );
                            },
                            child: Text('Download Pdf'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(child: SizedBox.shrink()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Color getGradeColor(String letterGrade) {
  switch (letterGrade) {
    case 'A':
      return Colors.green;
    case 'B':
      return AppTheme.primaryColorA0;
    case 'C':
      return Colors.yellow;
    case 'D':
      return Colors.orange;
    default:
      return Colors.red;
  }
}
