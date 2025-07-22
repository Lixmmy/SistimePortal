import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nilai_event.dart';
part 'nilai_state.dart';

class NilaiBloc extends Bloc<NilaiEvent, NilaiState> {
  NilaiBloc() : super(NilaiInitial()) {
    on<NilaiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
