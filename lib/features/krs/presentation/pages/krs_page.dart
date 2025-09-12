import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/injection.dart';

class KrsPage extends StatefulWidget {
  const KrsPage({super.key});

  @override
  State<KrsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  @override
  void initState() {
    super.initState();
    myInjection<KrsBloc>().add(const FetchKrsData(nim: '2244068'));
  }

  @override
  Widget build(BuildContext context) {
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
            BlocBuilder<KrsBloc, KrsState>(
              bloc: myInjection<KrsBloc>(),
              builder: (context, state) {
                if (state is KrsError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Gagal memuat data: ${state.message}'),
                    ),
                  );
                } else if (state is KrsLoaded) {
                  if (state.groupedKrs.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('Tidak ada data KRS ditemukan.'),
                      ),
                    );
                  }
                  // Get the sorted list of semesters
                  final semesters = state.groupedKrs.keys.toList();

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final semester = semesters[index];
                        final krsList = state.groupedKrs[semester]!;
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ExpansionTile(
                            title: Text(
                              'Semester $semester',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            children: krsList.map((krs) {
                              return ListTile(
                                title: Text(krs.namaMatakuliah),
                                subtitle: Text(krs.kodeMatakuliah),
                                trailing: Text(krs.namaDosen),
                              );
                            }).toList(),
                          ),
                        );
                      },
                      childCount: semesters.length,
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(child: Text('Silakan muat data KRS.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
