import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/core/error/failure.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/domain/usecases/get_mahasiswa.dart';
import 'package:dartz/dartz.dart';
part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  final GetMahasiswa getMahasiswa;
  ProfilBloc({required this.getMahasiswa}) : super(ProfilInitial()) {
    on<ProfilGetMahasiswa>((event, emit) async{
      emit(ProfilLoading());
      Either<Failure, Profil> hasilGetMahasiswa = await getMahasiswa.execute(event.nim);
      hasilGetMahasiswa.fold((leftHasilGetMahasiswa){
       emit( ProfilError(message: 'Cannot get mahasiswa data'));
      }, (rightHasilGetMahasiswa){
        emit(ProfilLoaded(rightHasilGetMahasiswa));
      });
    },);
  }
}
