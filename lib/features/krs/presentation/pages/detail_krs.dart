import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';

class DetailKrs extends StatefulWidget {
  const DetailKrs({super.key, required this.semester});
  final int semester;

  @override
  State<DetailKrs> createState() => _DetailKrsState();
}

class _DetailKrsState extends State<DetailKrs> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocListener<KrsBloc, KrsState>(
        bloc: myInjection<KrsBloc>(),
        listener: (context, state) {
          if (state is KrsPdfDownloaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("berhasil download pdf"),
                duration: Duration(seconds: 1),
              ),
            );
            myInjection<KrsBloc>().add(const FetchKrsData(nim: '530'));
          }
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
            BlocBuilder<KrsBloc, KrsState>(
              bloc: myInjection<KrsBloc>(),
              builder: (context, state) {
                if (state is KrsLoaded) {
                  final krs = state.groupedKrs[widget.semester]!;
                  return SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalizations.studyPlanCard,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                '${appLocalizations.semester}: ${widget.semester}',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final krsItem = krs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 5),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    krsItem.namaMatakuliah,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${appLocalizations.code}: ${krsItem.kodeMatakuliah} | ${appLocalizations.sks}: ${krsItem.sks}\n',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                        TextSpan(
                                          text:
                                              '${appLocalizations.lecture}: ${krsItem.namaDosen}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppTheme.primaryColorA0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }, childCount: krs.length),
                      ),
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(appLocalizations.submit),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                myInjection<KrsBloc>().add(
                                  DownloadKrsPdf(
                                    appLocalizations: appLocalizations,
                                    semester: widget.semester,
                                  ),
                                );
                              },
                              child: Text('Download Pdf'),
                            ),
                          ],
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
