part of 'profil_bloc.dart';

abstract class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object?> get props => [];
}

class ProfilGetMahasiswa extends ProfilEvent {}

class ProfilUpdateMahasiswa extends ProfilEvent {
  final String idUser;
  final UpdateMahasiswaModel updateProfil;

  const ProfilUpdateMahasiswa({
    required this.idUser,
    required this.updateProfil,
  });

  @override
  List<Object?> get props => [idUser, updateProfil];
}

class LogOutProfil extends ProfilEvent {}
