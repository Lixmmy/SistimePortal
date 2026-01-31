import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'agama_event.dart';
part 'agama_state.dart';

class AgamaBloc extends Bloc<AgamaEvent, AgamaState> {
  AgamaBloc() : super(AgamaInitial()) {
    on<AgamaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
