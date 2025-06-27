import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc() : super(ProfilInitial()) {
    on<ProfilEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
