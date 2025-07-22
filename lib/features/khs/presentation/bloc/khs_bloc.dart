import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'khs_event.dart';
part 'khs_state.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  KhsBloc() : super(KhsInitial()) {
    on<KhsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
