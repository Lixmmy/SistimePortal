import 'package:flutter/material.dart';
import 'package:sistime_portal/core/helper/grade_converter.dart';
import 'package:sistime_portal/core/localization/localization_service.dart';
import 'package:sistime_portal/features/transkrip/presentation/bloc/transkrip_bloc.dart';

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
        final String letterGrade = transkrip.letterGrade ?? '';
        final Color gradeColor = getGradeColor(letterGrade);

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Text(
              transkrip.matkul,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            subtitle: Text(
              '${appL10n.code}: ${transkrip.kodeMatkul} | ${appL10n.sks}: ${transkrip.sks}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              letterGrade,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: gradeColor),
            ),
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
      },
    );
  }
}
