import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? username;
  final String? keterangan;
  const User({this.id, this.username, this.keterangan});
  @override
  List<Object?> get props => [id, username, keterangan];
  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'keterangan': keterangan};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      keterangan: json['keterangan'],
    );
  }
}

class Agama extends Equatable {
  final String? idAgama;
  final String? agama;
  const Agama({this.idAgama, this.agama});
  @override
  List<Object?> get props => [idAgama, agama];
  Map<String, dynamic> toJson() {
    return {'idAgama': idAgama, 'agama': agama};
  }

  factory Agama.fromJson(Map<String, dynamic> json) {
    return Agama(idAgama: json['idAgama'], agama: json['agama']);
  }
}

class Kampus extends Equatable {
  final String? kodeKampus;
  final String? keterangan;

  const Kampus({this.kodeKampus, this.keterangan});
  @override
  List<Object?> get props => [kodeKampus, keterangan];
  Map<String, dynamic> toJson() {
    return {'kodeKampus': kodeKampus, 'keterangan': keterangan};
  }

  factory Kampus.fromJson(Map<String, dynamic> json) {
    return Kampus(
      kodeKampus: json['kodeKampus'],
      keterangan: json['keterangan'],
    );
  }
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
  Map<String, dynamic> toJson() {
    return {
      'kodeProgramStudi': kodeProgramStudi,
      'keterangan': keterangan,
      'namaProgramStudi': namaProgramStudi,
    };
  }

  factory ProgramStudi.fromJson(Map<String, dynamic> json) {
    return ProgramStudi(
      kodeProgramStudi: json['kodeProgramStudi'],
      keterangan: json['keterangan'],
      namaProgramStudi: json['namaProgramStudi'],
    );
  }
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
  Map<String, dynamic> toJson() {
    return {
      'idSekolah': idSekolah,
      'alamatSekolah': alamatSekolah,
      'keterangan': keterangan,
      'namaSekolah': namaSekolah,
    };
  }

  factory Sekolah.fromJson(Map<String, dynamic> json) {
    return Sekolah(
      idSekolah: json['idSekolah'],
      alamatSekolah: json['alamatSekolah'],
      keterangan: json['keterangan'],
      namaSekolah: json['namaSekolah'],
    );
  }
}

class Status extends Equatable {
  final int? idStatus;
  final String? status;
  const Status({this.idStatus, this.status});
  @override
  List<Object?> get props => [idStatus, status];
  Map<String, dynamic> toJson() {
    return {'idStatus': idStatus, 'status': status};
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(idStatus: json['idStatus'], status: json['status']);
  }
}

class WaktuKuliah extends Equatable {
  final int? idWaktuKuliah;
  final String? waktuKuliah;
  final String? keterangan;
  const WaktuKuliah({this.idWaktuKuliah, this.waktuKuliah, this.keterangan});
  @override
  List<Object?> get props => [idWaktuKuliah, waktuKuliah, keterangan];
  Map<String, dynamic> toJson() {
    return {
      'idWaktuKuliah': idWaktuKuliah,
      'waktuKuliah': waktuKuliah,
      'keterangan': keterangan,
    };
  }

  factory WaktuKuliah.fromJson(Map<String, dynamic> json) {
    return WaktuKuliah(
      idWaktuKuliah: json['idWaktuKuliah'],
      waktuKuliah: json['waktuKuliah'],
      keterangan: json['keterangan'],
    );
  }
}
