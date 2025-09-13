import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';

class DetailKhs extends StatefulWidget {
  const DetailKhs({super.key, required this.khs, required this.semester});
  final List<Transkrip> khs;
  final int semester;

  @override
  State<DetailKhs> createState() => _DetailKrsState();
}

class _DetailKrsState extends State<DetailKhs> {
  @override
  void initState() {
    super.initState();
    myInjection<KhsBloc>().add(const FetchKhsData(nim: '2244068'));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocListener<KhsBloc, KhsState>(
        bloc: myInjection<KhsBloc>(),
        listener: (context, state) {
          if (state is KhsLoading) {
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
            BlocBuilder<KhsBloc, KhsState>(
              bloc: myInjection<KhsBloc>(),
              builder: (context, state) {
                if (state is KhsLoaded) {
                  final khs = widget.khs;
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
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final khsItem = khs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  khsItem.matkul,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                subtitle: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Kode: ${khsItem.kodeMatkul} | SKS: ${khsItem.sks}',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      // TextSpan(
                                      //   text: 'Dosen: ${khsItem.}',
                                      //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      //     color: AppTheme.primaryColorA0,
                                      //   ),
                                      // ),
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
                          childCount: khs.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {},
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
