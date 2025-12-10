part of 'profil_bloc.dart';

abstract class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object?> get props => [];
}

class ProfilGetMahasiswa extends ProfilEvent {}
