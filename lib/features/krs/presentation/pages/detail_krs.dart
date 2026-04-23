import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/core/localization/l10n/app_localizations.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';

class DetailKrs extends StatefulWidget {
  final int idTahunAjaran;
  const DetailKrs({super.key, required this.idTahunAjaran});

  @override
  State<DetailKrs> createState() => _DetailKrsState();
}

class _DetailKrsState extends State<DetailKrs> {
  late KrsBloc _krsBloc;
  @override
  void initState() {
    super.initState();
    _krsBloc = context.read<KrsBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _krsBloc.add(FetchMatakuliah(idTahunAjaran: widget.idTahunAjaran));
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
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
            builder: (context, state) {
              if (state is KrsLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is KrsLoadedMatakuliah) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final matkul = state.matakuliahWajib[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withAlpha(150)
                                : Colors.black.withAlpha(150),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              matkul.matkul.namaMataKuliah,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${appLocalizations.code}: ${matkul.matkul.kodeMataKuliah} | ${appLocalizations.sks}: ${matkul.matkul.sks}\n',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                    text:
                                        '${appLocalizations.lecture}: ${matkul.dosen.namaDosen}',
                                    style: Theme.of(context).textTheme.bodySmall
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
                  }, childCount: state.matakuliahWajib.length),
                );
              }
              return SliverToBoxAdapter(
                child: Center(child: SizedBox.shrink()),
              );
            },
          ),
        ],
      ),
    );
  }
}
