import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistime_portal/features/status/domain/entities/status.dart';
import 'package:sistime_portal/features/status/domain/usescase/get_status.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final GetStatus _getStatus;

  StatusBloc({required GetStatus getStatus})
    : _getStatus = getStatus,
      super(StatusInitial()) {
    on<FetchStatusList>((event, emit) async {
      emit(StatusLoading());
      final result = await _getStatus.execute();
      result.fold(
        (failure) => emit(StatusError(failure.message)),
        (statusList) => emit(StatusLoaded(statusList)),
      );
    });
  }
}
