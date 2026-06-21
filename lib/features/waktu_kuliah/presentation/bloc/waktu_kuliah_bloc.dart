import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistime_portal/features/waktu_kuliah/domain/entities/waktu_kuliah.dart';
import 'package:sistime_portal/features/waktu_kuliah/domain/usecases/get_waktu_kuliah.dart';

part 'waktu_kuliah_event.dart';
part 'waktu_kuliah_state.dart';

class WaktuKuliahBloc extends Bloc<WaktuKuliahEvent, WaktuKuliahState> {
  final GetWaktuKuliah _getWaktuKuliah;

  WaktuKuliahBloc({required GetWaktuKuliah getWaktuKuliah})
    : _getWaktuKuliah = getWaktuKuliah,
      super(WaktuKuliahInitial()) {
    on<FetchWaktuKuliahList>((event, emit) async {
      emit(WaktuKuliahLoading());
      final result = await _getWaktuKuliah.execute();
      result.fold(
        (failure) => emit(WaktuKuliahError(failure.message)),
        (waktuKuliahList) => emit(WaktuKuliahLoaded(waktuKuliahList)),
      );
    });
  }
}
