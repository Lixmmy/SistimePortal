import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'nilai_event.dart';
part 'nilai_state.dart';

class NilaiBloc extends Bloc<NilaiEvent, NilaiState> {
  NilaiBloc() : super(NilaiInitial()) {
    on<NilaiEvent>((event, emit) {
    });
  }
}
