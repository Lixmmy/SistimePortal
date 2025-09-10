import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/features/transkrip/domain/usecases/get_transkrip.dart';

part 'transkrip_event.dart';
part 'transkrip_state.dart';

class TranskripBloc extends Bloc<TranskripEvent, TranskripState> {
  final GetTranskrip _getTranskrip;

  TranskripBloc({required GetTranskrip getTranskrip})
    : _getTranskrip = getTranskrip,
      super(TranskripInitial()) {
    on<GetListTranskrip>((event, emit) async {
      emit(TranskripLoading());
      try {
        final result = await _getTranskrip.execute(event.nim);
        result.fold(
          (failure) => emit(TranskripError(message: failure.message)),
          (data) => emit(TranskripLoaded(listTranskrip: data)),
        );
      } catch (e) {
        emit(TranskripError(message: e.toString()));
      }
    });
  }
}
