import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/profil.dart';
import '../../domain/usecases/get_mahasiswa.dart';
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
       emit( ProfilError(message: leftHasilGetMahasiswa.toString()));
      }, (rightHasilGetMahasiswa){
        emit(ProfilLoaded(rightHasilGetMahasiswa));
      });
    },);
  }
}
