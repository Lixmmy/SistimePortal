import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';

class KhsPage extends StatefulWidget {
  const KhsPage({super.key});

  @override
  State<KhsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KhsPage> {
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
            BlocBuilder<KhsBloc, KhsState>(
              bloc: myInjection<KhsBloc>(),
              builder: (context, state) {
                if (state is KhsLoaded) {
                  if (state.groupedKhs.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('Tidak ada data KHS ditemukan.'),
                      ),
                    );
                  }
                  final semesters = state.groupedKhs.keys.toList();

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final semester = semesters[index];
                      final krsList = state.groupedKhs[semester]!;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            '${appLocalizations.semester} $semester',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onTap: () {
                            context.pushNamed(
                              'detailKhsPage',
                              extra: {'khsList': krsList, 'semester': semester},
                            );
                          },
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black.withAlpha(150),
                            ),
                          ),
                        ),
                      );
                    }, childCount: semesters.length),
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
