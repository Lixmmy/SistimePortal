import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:newsistime/features/krs/domain/usecases/get_mata_kuliah.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/features/transkrip/domain/usecases/get_transkrip.dart';

part 'khs_event.dart';
part 'khs_state.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  final GetTranskrip getTranskrip;
  final GetMataKuliah getMataKuliah;

  KhsBloc({required this.getTranskrip, required this.getMataKuliah})
    : super(KhsInitial()) {
    on<FetchKhsData>((event, emit) async {
      emit(KhsLoading());
      try {
        final khsResult = await getTranskrip.execute(event.nim);
        final matkulResult = await getMataKuliah.execute();

        final khsEither = khsResult;
        final matkulEither = matkulResult;

        if (khsEither.isLeft() || matkulEither.isLeft()) {
          // Handle error from either use case
          final errorMessage =
              khsEither.fold((l) => l.message, (r) => '') +
              matkulEither.fold((l) => l.message, (r) => '');
          emit(KhsError(message: errorMessage));
          return;
        }

        final khsList = khsEither.getOrElse(() => []);
        final matkulList = matkulEither.getOrElse(() => []);

        final matkulMap = {
          for (var matkul in matkulList) matkul.kodeMataKuliah: matkul,
        };
        final groupedKrs = <int, List<Transkrip>>{};

        for (var khs in khsList) {
          final matkul = matkulMap[khs.kodeMatkul];
          if (matkul != null) {
            final semester = matkul.semester;
            if (!groupedKrs.containsKey(semester)) {
              groupedKrs[semester] = [];
            }
            final khsWithSks = Transkrip(
              krsId: khs.krsId,
              kodeMatkul: khs.kodeMatkul,
              matkul: khs.matkul,
              sks: khs.sks,
              nilai: khs.nilai,
              letterGrade: khs.letterGrade,
            );
            groupedKrs[semester]!.add(khsWithSks);
          }
        }

        // Sort keys (semesters) in ascending order
        final sortedGroupedKrs = Map.fromEntries(
          groupedKrs.entries.toList()
            ..sort((e1, e2) => e1.key.compareTo(e2.key)),
        );

        emit(KhsLoaded(groupedKhs: sortedGroupedKrs));
      } catch (e) {
        emit(KhsError(message: e.toString()));
      }
    });
  }
}
