import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dosen_event.dart';
part 'dosen_state.dart';

class DosenBloc extends Bloc<DosenEvent, DosenState> {
  DosenBloc() : super(DosenInitial()) {
    on<DosenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
