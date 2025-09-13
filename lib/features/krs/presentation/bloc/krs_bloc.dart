import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/usecases/get_krs.dart';
import 'package:newsistime/features/krs/domain/usecases/get_mata_kuliah.dart';

part 'krs_event.dart';
part 'krs_state.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  final GetKrs getKrs;
  final GetMataKuliah getMataKuliah;

  KrsBloc({required this.getKrs, required this.getMataKuliah}) : super(KrsInitial()) {
    on<FetchKrsData>((event, emit) async {
      emit(KrsLoading());
      try {
        final krsResult = await getKrs.execute(event.nim);
        final matkulResult = await getMataKuliah.execute();

        final krsEither = krsResult;
        final matkulEither = matkulResult;

        if (krsEither.isLeft() || matkulEither.isLeft()) {
          // Handle error from either use case
          final errorMessage = krsEither.fold((l) => l.message, (r) => '') +
              matkulEither.fold((l) => l.message, (r) => '');
          emit(KrsError(message: errorMessage));
          return;
        }

        final krsList = krsEither.getOrElse(() => []);
        final matkulList = matkulEither.getOrElse(() => []);

        final matkulMap = {for (var matkul in matkulList) matkul.kodeMataKuliah: matkul};
        final groupedKrs = <int, List<Krs>>{};

        for (var krs in krsList) {
          final matkul = matkulMap[krs.kodeMatakuliah];
          if (matkul != null) {
            final semester = matkul.semester;
            if (!groupedKrs.containsKey(semester)) {
              groupedKrs[semester] = [];
            }
            // Create a new Krs object with the sks value from matkul
            final krsWithSks = Krs(
              idKrs: krs.idKrs,
              idSkemaKrs: krs.idSkemaKrs,
              kodeMatakuliah: krs.kodeMatakuliah,
              namaMatakuliah: krs.namaMatakuliah,
              namaDosen: krs.namaDosen,
              sks: matkul.sks, // Assign the sks value here
            );
            groupedKrs[semester]!.add(krsWithSks);
          }
        }
        
        // Sort keys (semesters) in ascending order
        final sortedGroupedKrs = Map.fromEntries(
          groupedKrs.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key))
        );

        emit(KrsLoaded(groupedKrs: sortedGroupedKrs));
      } catch (e) {
        emit(KrsError(message: e.toString()));
      }
    });
  }
}
