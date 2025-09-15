import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
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
      body: BlocBuilder<KhsBloc, KhsState>(
        bloc: myInjection<KhsBloc>(),
        builder: (context, state) {
          if (state is KhsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is KhsLoaded) {
            if (state.groupedKhs.isEmpty) {
              return const Center(
                child: Text('Tidak ada data KHS ditemukan.'),
              );
            }
            final semesters = state.groupedKhs.keys.toList();
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
                            'detailKhsPage',
                            extra: {'semester': semester},
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
                ),
              ],
            );
          }
          return const Center(
            child: SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
