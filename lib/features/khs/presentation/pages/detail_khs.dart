import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/helper/grade_converter.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:newsistime/injection.dart';
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
    return Scaffold(
      body: CustomScrollView(
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
          BlocConsumer<KhsBloc, KhsState>(
            listener: (context, state) {},
            buildWhen: (previous, current) {
              if (current is KhsTokenExpired ||
                  current is KhsError ||
                  current is KhsPdfDownloaded) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state is KhsLoaded) {
                final khs = state.groupedKhs[widget.semester];
                return SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appL10n.studyResultsCard,
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
                                value: state.profil.namaMahasiswa,
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
                                    state
                                        .profil
                                        .programStudi
                                        ?.namaProgramstudi ??
                                    '',
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
                                label: appL10n.semester,
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
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Text(
                                  '${appL10n.code}: ${khsItem?.kodeMatakuliah ?? ''} | ${appL10n.sks}: ${khsItem?.sks ?? ''}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (khsItem?.nilais?.absensi != null)
                                            BuildInfoRow(
                                              label: appL10n.attendanceGrade,
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
                                              label: appL10n.quizGrade,
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
                                              label: appL10n.assignmentGrade,
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
                                          if (khsItem?.nilais?.project != null)
                                            BuildInfoRow(
                                              label: appL10n.projectScore,
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
                                              label: appL10n.midTermGrade,
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
                                              label: appL10n.finalGrade,
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
                                              label: appL10n.improvement,
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
                                appLocalizations: appL10n,
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
    );
  }
}
