import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/core/localization/l10n/app_localizations.dart';
import 'package:quickalert/quickalert.dart';

class KrsPage extends StatefulWidget {
  const KrsPage({super.key});

  @override
  State<KrsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  late KrsBloc _krsBloc;

  @override
  void initState() {
    super.initState();
    _krsBloc = context.read<KrsBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _krsBloc.add(FetchKrsData());
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<KrsBloc, KrsState>(
        listener: (context, state) {
          if (state is KrsTokenExpired) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "Session Expired",
              text: state.message,
              onConfirmBtnTap: () {
                context.goNamed('launcherPage');
              },
            );
          }
          if (state is KrsError) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "error",
              text: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is KrsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is KrsTokenExpired) {
            return Center(child: Text(state.message));
          }
          if (state is KrsLoaded) {
            if (state.groupedKrs.isEmpty) {
              return Center(child: Text('Tidak ada data KRS ditemukan.'));
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
                            color:
                                Theme.of(context).brightness == Brightness.dark
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
          return const Center(child: Text('Tidak ada data KRS ditemukan.'));
        },
      ),
    );
  }
}
