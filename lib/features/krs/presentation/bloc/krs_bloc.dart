import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'krs_event.dart';
part 'krs_state.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  KrsBloc() : super(KrsInitial()) {
    on<KrsEvent>((event, emit) {
    });
  }
}
