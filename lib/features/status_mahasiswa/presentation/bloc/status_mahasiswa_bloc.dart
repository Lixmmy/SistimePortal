import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_mahasiswa_event.dart';
part 'status_mahasiswa_state.dart';

class StatusMahasiswaBloc extends Bloc<StatusMahasiswaEvent, StatusMahasiswaState> {
  StatusMahasiswaBloc() : super(StatusMahasiswaInitial()) {
    on<StatusMahasiswaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
