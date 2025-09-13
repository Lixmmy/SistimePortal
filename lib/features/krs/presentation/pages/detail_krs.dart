import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';

class DetailKrs extends StatefulWidget {
  const DetailKrs({super.key, required this.krs, required this.semester});
  final List<Krs> krs;
  final int semester;

  @override
  State<DetailKrs> createState() => _DetailKrsState();
}

class _DetailKrsState extends State<DetailKrs> {
  @override
  void initState() {
    super.initState();
    myInjection<KrsBloc>().add(const FetchKrsData(nim: '2244068'));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocListener<KrsBloc, KrsState>(
        bloc: myInjection<KrsBloc>(),
        listener: (context, state) {
          if (state is KrsLoading) {
            LoadingManager().show(context);
          } else {
            if (LoadingManager().isShowing) {
              LoadingManager().dismiss();
            }
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
            BlocBuilder<KrsBloc, KrsState>(
              bloc: myInjection<KrsBloc>(),
              builder: (context, state) {
                if (state is KrsLoaded) {
                  final krs = widget.krs;
                  return SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            appLocalizations.studyPlanCard,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final krsItem = krs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  krsItem.namaMatakuliah,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                subtitle: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Kode: ${krsItem.kodeMatakuliah} | SKS: ${krsItem.sks}\n',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      TextSpan(
                                        text: 'Dosen: ${krsItem.namaDosen}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppTheme.primaryColorA0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withAlpha(150),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: krs.length,
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
