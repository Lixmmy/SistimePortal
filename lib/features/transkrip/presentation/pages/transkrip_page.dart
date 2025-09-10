import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/features/transkrip/domain/function/grade_converter.dart';

class TranskripPage extends StatefulWidget {
  const TranskripPage({super.key});

  @override
  State<TranskripPage> createState() => _TranskripPageState();
}

class _TranskripPageState extends State<TranskripPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: myInjection<TranskripBloc>()
          ..add(const GetListTranskrip('2244068')),
        listener: (context, state) {
          if (state is TranskripError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('error: ${state.message}'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
          if (state is TranskripLoading) {
            LoadingManager().show(context);
          } else {
            if (LoadingManager().isShowing) {
              LoadingManager().dismiss();
            }
          }
        },
        builder: (context, state) {
          if (state is TranskripLoaded) {
            return ListView.builder(
              itemCount: state.listTranskrip.length,
              itemBuilder: (context, index) {
                final transkrip = state.listTranskrip[index];
                final nilai = transkrip.nilai;
                String letterGrade =
                    'N/A'; // Default value if nilai is null or incomplete

                if (nilai != null) {
                  final List<double> scores = [
                    nilai.tugas,
                    nilai.uts,
                    nilai.uas,
                    nilai.absensi,
                    nilai.project ?? 0,
                    nilai.quiz ?? 0,
                  ];
                  if (scores.isNotEmpty) {
                    final double averageScore =
                        scores.reduce((a, b) => a + b) / scores.length;
                    print(averageScore);
                    letterGrade = konversiNilaiKeHuruf(averageScore);
                  }
                }

                return ListTile(
                  title: Text(transkrip.matkul), // Display full course name
                  subtitle: Text(
                    'Kode: ${transkrip.kodeMatkul} | SKS: ${transkrip.sks} | Nilai: $letterGrade',
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
