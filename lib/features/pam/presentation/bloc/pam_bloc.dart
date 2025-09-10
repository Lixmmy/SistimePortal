import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'pam_event.dart';
part 'pam_state.dart';

class PamBloc extends Bloc<PamEvent, PamState> {
  PamBloc() : super(PamInitial()) {
    on<PamEvent>((event, emit) {
    });
  }
}
