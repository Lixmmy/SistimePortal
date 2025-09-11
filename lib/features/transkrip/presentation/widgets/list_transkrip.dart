import 'package:flutter/material.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:newsistime/features/transkrip/domain/function/grade_converter.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';

class ListTranskrip extends StatelessWidget {
  final TranskripLoaded state;
  const ListTranskrip({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.listTranskrip.length,
      itemBuilder: (context, index) {
        final transkrip = state.listTranskrip[index];
        final nilai = transkrip.nilai;
        String letterGrade = 'N/A';
        Color gradeColor = Colors.red;

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
            final double averageScore = scores.reduce((a, b) => a + b) /
                (nilai.project == 0 ? scores.length : 4);

            letterGrade = konversiNilaiKeHuruf(averageScore);
            gradeColor = _getGradeColor(letterGrade);
          }
        }

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Text(
              transkrip.matkul,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            subtitle: Text(
              'Kode: ${transkrip.kodeMatkul} | SKS: ${transkrip.sks}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              letterGrade,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: gradeColor),
            ),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black.withAlpha(150)),
            ),
          ),
        );
      },
    );
  }

  Color _getGradeColor(String letterGrade) {
    switch (letterGrade) {
      case 'A':
        return Colors.green;
      case 'B':
        return AppTheme.primaryColorA0;
      case 'C':
        return Colors.yellow;
      case 'D':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}