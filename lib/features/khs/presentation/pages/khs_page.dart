import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class KhsPage extends StatefulWidget {
  const KhsPage({super.key});

  @override
  State<KhsPage> createState() => _KhsPageState();
}

class _KhsPageState extends State<KhsPage> {
  late KhsBloc _khsBloc;

  @override
  void initState() {
    super.initState();
    _khsBloc = context.read<KhsBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _khsBloc.add(FetchKhsData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KhsBloc, KhsState>(
      listener: (context, state) {
        if (state is KhsError) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: appL10n.error,
            text: state.message,
            onConfirmBtnTap: () {
              if (state.message.toLowerCase().contains('token')) {
                context.goNamed('launcherPage');
              } else {
                context.pop();
              }
            },
          );
        }
      },

      builder: (context, state) {
        if (state is KhsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is KhsLoaded) {
          if (state.groupedKhs.isEmpty) {
            return const Center(child: Text('Tidak ada data KHS ditemukan.'));
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
                        '${appL10n.semester} $semester',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onTap: () async {
                        await context.pushNamed(
                          'detailKhsPage',
                          extra: {'semester': semester},
                        );
                        _khsBloc.add(FetchKhsData());
                      },
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
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
        return const Center(child: SizedBox.shrink());
      },
    );
  }
}
