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
            myInjection<KhsBloc>().add(FetchKhsData());
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
                  final khs = state.groupedKhs[widget.semester];
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
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white.withAlpha(150)
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
                                BuildInfoRow(
                                  label: appLocalizations.semester,
                                  value: widget.semester.toString(),
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
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final khsItem = khs?[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white.withAlpha(150)
                                      : Colors.black.withAlpha(150),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    khsItem?.namaMatakuliah ?? '',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                  Text(
                                    '${appLocalizations.code}: ${khsItem?.kodeMatakuliah ?? ''} | ${appLocalizations.sks}: ${khsItem?.sks ?? ''}',
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
                                            if (khsItem?.nilais?.absensi !=
                                                null)
                                              BuildInfoRow(
                                                label: appLocalizations
                                                    .attendanceGrade,
                                                value:
                                                    khsItem?.nilais?.absensi
                                                        ?.toString() ??
                                                    '',
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                                labelColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            if (khsItem?.nilais?.quiz != null)
                                              BuildInfoRow(
                                                label:
                                                    appLocalizations.quizGrade,
                                                value:
                                                    khsItem?.nilais?.quiz
                                                        ?.toString() ??
                                                    '',
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                                labelColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            if (khsItem?.nilais?.tugas != null)
                                              BuildInfoRow(
                                                label: appLocalizations
                                                    .assignmentGrade,
                                                value:
                                                    khsItem?.nilais?.tugas
                                                        ?.toString() ??
                                                    '',
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                                labelColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            if (khsItem?.nilais?.project !=
                                                null)
                                              BuildInfoRow(
                                                label: appLocalizations
                                                    .projectScore,
                                                value:
                                                    khsItem?.nilais?.project
                                                        ?.toString() ??
                                                    '',
                                                labelColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                              ),
                                            if (khsItem?.nilais?.uts != null)
                                              BuildInfoRow(
                                                label: appLocalizations
                                                    .midTermGrade,
                                                value:
                                                    khsItem?.nilais?.uts
                                                        ?.toString() ??
                                                    '',
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                                labelColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            if (khsItem?.nilais?.uas != null)
                                              BuildInfoRow(
                                                label:
                                                    appLocalizations.finalGrade,
                                                value:
                                                    khsItem?.nilais?.uas
                                                        ?.toString() ??
                                                    '',
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                                labelColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            if (khsItem?.nilais?.perbaikan !=
                                                null)
                                              BuildInfoRow(
                                                label: appLocalizations
                                                    .improvement,
                                                value:
                                                    khsItem?.nilais?.perbaikan
                                                        ?.toString() ??
                                                    '',
                                                valueColor:
                                                    AppTheme.primaryColorA0,
                                                labelColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (khsItem?.letterGrade != '')
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            khsItem?.letterGrade ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                  color: getGradeColor(
                                                    khsItem?.letterGrade ?? '',
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
                        }, childCount: khs?.length),
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
