import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/localization/l10n/app_localizations.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/features/krs/domain/entities/jadwal_krs.dart';
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
    return Scaffold(
      body: BlocConsumer<KrsBloc, KrsState>(
        listener: (context, state) {},
        buildWhen: (previous, current) {
          if (current is KrsTokenExpired ||
              current is KrsError ||
              current is KrsPdfDownloaded ||
              current is KrsPostSuccess) {
            return false;
          }
          return true; // Rebuild UI untuk state lainnya
        },
        builder: (context, state) {
          if (state is KrsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is KrsLoadedMatakuliah) {
            return CustomScrollView(
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

                SliverMainAxisGroup(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final matkul = state.matakuliahWajib[index];
                        return _buildMatkulItem(context, matkul, appL10n);
                      }, childCount: state.matakuliahWajib.length),
                    ),
                    if (state.selectedMatakuliahPilihan.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            appL10n.optionalAdditionalCourses,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    if (state.selectedMatakuliahPilihan.isNotEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final matkul = state.selectedMatakuliahPilihan[index];
                          return _buildMatkulItem(context, matkul, appL10n);
                        }, childCount: state.selectedMatakuliahPilihan.length),
                      ),
                    if (!state.isAlreadyFilled)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showMatakuliahPilihan(context, state);
                                  },
                                  child: Text(appL10n.addCourse),
                                ),
                              ),
                              Flexible(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _krsBloc.add(PostKrsEvent());
                                  },
                                  child: Text(appL10n.submit),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16.0,
                        ),
                        child: Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              _krsBloc.add(
                                DownloadKrsPdf(appLocalizations: appL10n),
                              );
                            },
                            child: Text(appL10n.downlaodPdf),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMatkulItem(
    BuildContext context,
    JadwalKrs matkul,
    AppLocalizations? appLocalizations,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
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
                        '${appLocalizations?.code}: ${matkul.matkul.kodeMataKuliah} | ${appLocalizations?.sks}: ${matkul.matkul.sks} | ${appL10n.roomClass}: ${matkul.kodeKelas}\n',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text:
                        '${appLocalizations?.lecture}: ${matkul.dosen.namaDosen}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
  }

  void _showMatakuliahPilihan(BuildContext context, KrsLoadedMatakuliah state) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<KrsBloc, KrsState>(
          bloc: _krsBloc,
          builder: (context, currentState) {
            if (currentState is KrsLoadedMatakuliah) {
              return AlertDialog(
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : AppTheme.surfaceDarkColorA10, // Background putih solid
                contentPadding: EdgeInsets.zero,
                content: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : AppTheme
                                  .surfaceDarkColorA10, // Background putih solid
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        border: Border(
                          bottom: BorderSide(color: Colors.black12),
                        ), // Garis pemisah tipis
                      ),
                      child: Text(
                        appL10n.chooseAdditionalCourse,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: currentState.matakuliahPilihan.length,
                          itemBuilder: (context, index) {
                            final matkul =
                                currentState.matakuliahPilihan[index];
                            final isSelected = currentState
                                .selectedMatakuliahPilihan
                                .contains(matkul);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 12.0,
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  matkul.matkul.namaMataKuliah,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                ),
                                subtitle: Text(
                                  '${matkul.matkul.kodeMataKuliah} | ${matkul.matkul.sks} ${appL10n.sks} | ${appL10n.roomClass}: ${matkul.kodeKelas}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                value: isSelected,
                                onChanged: (bool? value) {
                                  _krsBloc.add(
                                    ToggleMatakuliahSelection(
                                      matakuliah: matkul,
                                    ),
                                  );
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                activeColor: AppTheme.primaryColorA0,
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: isSelected
                                        ? AppTheme.primaryColorA0
                                        : Theme.of(context).dividerColor,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: isSelected
                                        ? AppTheme.primaryColorA0
                                        : Theme.of(context).dividerColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                dense: true,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : AppTheme
                                  .surfaceDarkColorA10, // Background putih solid
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        border: Border(
                          top: BorderSide(color: Colors.black12),
                        ), // Garis pemisah tipis
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(appL10n.finish),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
