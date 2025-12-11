import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';

class KrsPage extends StatefulWidget {
  const KrsPage({super.key});

  @override
  State<KrsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<ProfilBloc, ProfilState>(
      bloc: myInjection<ProfilBloc>(),
      listener: (context, state) {
        if (state is ProfilLoaded) {
          final krsBloc = myInjection<KrsBloc>();
          if (krsBloc.state is KrsInitial) {
            krsBloc.add(FetchKrsData());
          }
        }
      },
      child: Scaffold(
        body: BlocBuilder<KrsBloc, KrsState>(
          bloc: myInjection<KrsBloc>(),
          builder: (context, state) {
            if (state is KrsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is KrsLoaded) {
              if (state.groupedKrs.isEmpty) {
                return const Center(
                    child: Text('Tidak ada data KRS ditemukan.'));
              }
              final semesters = state.groupedKrs.keys.toList();
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final semester = semesters[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            '${appLocalizations.semester} $semester',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onTap: () {
                            context.pushNamed(
                              'detailKrsPage',
                              extra: {'semester': semester},
                            );
                          },
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white.withAlpha(150)
                                  : Colors.black.withAlpha(150),
                            ),
                          ),
                        ),
                      );
                    }, childCount: semesters.length),
                  ),
                ],
              );
            }
            if (state is KrsError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: SizedBox.shrink());
          },
        ),
      ),
    );
  }
}