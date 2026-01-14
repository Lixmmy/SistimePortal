import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import '../../domain/entities/profil.dart';
import '../../domain/usecases/get_mahasiswa.dart';
import 'package:dartz/dartz.dart';
part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  final GetMahasiswa getMahasiswa;
  ProfilBloc({required this.getMahasiswa}) : super(ProfilInitial()) {
    on<ProfilGetMahasiswa>((event, emit) async {
      emit(ProfilLoading());
      final username = await SecureStorage().getData('username');
      if (username.isEmpty) {
        emit(ProfilError(message: 'Username not found in storage.'));
        return;
      }
      Either<MessageExc, Profil> hasilGetMahasiswa = await getMahasiswa.execute(
        username,
      );
      hasilGetMahasiswa.fold(
        (leftHasilGetMahasiswa) {
          emit(ProfilError(message: leftHasilGetMahasiswa.toString()));
        },
        (rightHasilGetMahasiswa) {
          emit(ProfilLoaded(rightHasilGetMahasiswa));
        },
      );
    });
  }
}
