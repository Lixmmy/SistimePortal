part of 'profil_bloc.dart';

abstract class ProfilEvent extends Equatable {
}

class ProfilGetMahasiswa extends ProfilEvent {
  final String nim;
  ProfilGetMahasiswa(this.nim);

  @override
  List<Object?> get props => [];
}
