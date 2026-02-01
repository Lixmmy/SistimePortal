import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/agama/domain/entities/agama.dart';
import 'package:newsistime/features/agama/domain/usecases/get_agama.dart';

part 'agama_event.dart';
part 'agama_state.dart';

class AgamaBloc extends Bloc<AgamaEvent, AgamaState> {
  final GetAgama _getAgama;

  AgamaBloc({required GetAgama getAgama})
      : _getAgama = getAgama,
        super(AgamaInitial()) {
    on<FetchAgamaList>((event, emit) async {
      emit(AgamaLoading());
      final result = await _getAgama.execute();
      result.fold(
        (failure) => emit(AgamaError(failure.message)),
        (agamaList) => emit(AgamaLoaded(agamaList)),
      );
    });
  }
}
