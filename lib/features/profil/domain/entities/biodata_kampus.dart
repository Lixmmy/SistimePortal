import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? username;
  final String? keterangan;
  const User({this.id, this.username, this.keterangan});
  @override
  List<Object?> get props => [id, username, keterangan];
}

class Agama extends Equatable {
  final String? idAgama;
  final String? agama;
  const Agama({this.idAgama, this.agama});
  @override
  List<Object?> get props => [idAgama, agama];
}

class Kampus extends Equatable {
  final String? kodeKampus;
  final String? keterangan;

  const Kampus({this.kodeKampus, this.keterangan});
  @override
  List<Object?> get props => [kodeKampus, keterangan];
}

class ProgramStudi extends Equatable {
  final String? kodeProgramStudi;
  final String? keterangan;
  final String? namaProgramStudi;
  const ProgramStudi({
    this.kodeProgramStudi,
    this.keterangan,
    this.namaProgramStudi,
  });
  @override
  List<Object?> get props => [kodeProgramStudi, keterangan, namaProgramStudi];
}

class Sekolah extends Equatable {
  final int? idSekolah;
  final String? alamatSekolah;
  final String? keterangan;
  final String? namaSekolah;
  const Sekolah({
    this.idSekolah,
    this.alamatSekolah,
    this.keterangan,
    this.namaSekolah,
  });
  @override
  List<Object?> get props => [
    idSekolah,
    alamatSekolah,
    keterangan,
    namaSekolah,
  ];
}

class Status extends Equatable {
  final int? idStatus;
  final String? status;
  const Status({this.idStatus, this.status});
  @override
  List<Object?> get props => [idStatus, status];
}

class WaktuKuliah extends Equatable {
  final int? idWaktuKuliah;
  final String? waktuKuliah;
  final String? keterangan;
  const WaktuKuliah({this.idWaktuKuliah, this.waktuKuliah, this.keterangan});
  @override
  List<Object?> get props => [idWaktuKuliah, waktuKuliah, keterangan];
}
