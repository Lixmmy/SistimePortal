import 'package:equatable/equatable.dart';
import 'package:newsistime/features/profil/domain/entities/biodata_kampus.dart';

class UserModel extends Equatable {
  final int? idModel;
  final String? usernameModel;
  final String? keteranganModel;

  const UserModel({this.idModel, this.usernameModel, this.keteranganModel});

  @override
  List<Object?> get props => [idModel, usernameModel, keteranganModel];

  factory UserModel.fromEntity(User entity) {
    return UserModel(
      idModel: entity.id,
      usernameModel: entity.username,
      keteranganModel: entity.keterangan,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idModel: json['id'],
      usernameModel: json['username'],
      keteranganModel: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idModel,
      'username': usernameModel,
      'keterangan': keteranganModel,
    };
  }

  User toEntity() {
    return User(
      id: idModel,
      username: usernameModel,
      keterangan: keteranganModel,
    );
  }
}

class AgamaModel extends Equatable {
  final String? idAgamaModel;
  final String? agamaModel;

  const AgamaModel({this.idAgamaModel, this.agamaModel});

  @override
  List<Object?> get props => [idAgamaModel, agamaModel];

  factory AgamaModel.fromEntity(Agama entity) {
    return AgamaModel(idAgamaModel: entity.idAgama, agamaModel: entity.agama);
  }

  factory AgamaModel.fromJson(Map<String, dynamic> json) {
    return AgamaModel(idAgamaModel: json['idAgama'], agamaModel: json['agama']);
  }

  Map<String, dynamic> toJson() {
    return {'idAgama': idAgamaModel, 'agama': agamaModel};
  }

  Agama toEntity() {
    return Agama(idAgama: idAgamaModel, agama: agamaModel);
  }
}

class KampusModel extends Equatable {
  final String? kodeKampusModel;
  final String? keteranganModel;

  const KampusModel({this.kodeKampusModel, this.keteranganModel});

  @override
  List<Object?> get props => [kodeKampusModel, keteranganModel];

  factory KampusModel.fromEntity(Kampus entity) {
    return KampusModel(
      kodeKampusModel: entity.kodeKampus,
      keteranganModel: entity.keterangan,
    );
  }

  factory KampusModel.fromJson(Map<String, dynamic> json) {
    return KampusModel(
      kodeKampusModel: json['kodeKampus'],
      keteranganModel: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'kodeKampus': kodeKampusModel, 'keterangan': keteranganModel};
  }

  Kampus toEntity() {
    return Kampus(kodeKampus: kodeKampusModel, keterangan: keteranganModel);
  }
}

class ProgramStudiModel extends Equatable {
  final String? kodeProgramStudiModel;
  final String? keteranganModel;
  final String? namaProgramstudiModel;

  const ProgramStudiModel({
    this.kodeProgramStudiModel,
    this.keteranganModel,
    this.namaProgramstudiModel,
  });

  @override
  List<Object?> get props => [
    kodeProgramStudiModel,
    keteranganModel,
    namaProgramstudiModel,
  ];

  factory ProgramStudiModel.fromEntity(ProgramStudi entity) {
    return ProgramStudiModel(
      kodeProgramStudiModel: entity.kodeProgramStudi,
      keteranganModel: entity.keterangan,
      namaProgramstudiModel: entity.namaProgramStudi,
    );
  }
  factory ProgramStudiModel.fromJson(Map<String, dynamic> json) {
    return ProgramStudiModel(
      kodeProgramStudiModel: json['kodeProgramstudi'],
      keteranganModel: json['keterangan'],
      namaProgramstudiModel: json['namaProgramstudi'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'kodeProgramstudi': kodeProgramStudiModel,
      'keterangan': keteranganModel,
      'namaProgramstudi': namaProgramstudiModel,
    };
  }

  ProgramStudi toEntity() {
    return ProgramStudi(
      kodeProgramStudi: kodeProgramStudiModel,
      keterangan: keteranganModel,
      namaProgramStudi: namaProgramstudiModel,
    );
  }
}

class SekolahModel extends Equatable {
  final int? idSekolahModel;
  final String? alamatSekolahModel;
  final String? keteranganModel;
  final String? namaSekolahModel;

  const SekolahModel({
    this.idSekolahModel,
    this.alamatSekolahModel,
    this.keteranganModel,
    this.namaSekolahModel,
  });

  @override
  List<Object?> get props => [
    idSekolahModel,
    alamatSekolahModel,
    keteranganModel,
    namaSekolahModel,
  ];

  factory SekolahModel.fromEntity(Sekolah entity) {
    return SekolahModel(
      idSekolahModel: entity.idSekolah,
      alamatSekolahModel: entity.alamatSekolah,
      keteranganModel: entity.keterangan,
      namaSekolahModel: entity.namaSekolah,
    );
  }

  factory SekolahModel.fromJson(Map<String, dynamic> json) {
    return SekolahModel(
      idSekolahModel: json['idSekolah'],
      alamatSekolahModel: json['alamatSekolah'],
      keteranganModel: json['keterangan'],
      namaSekolahModel: json['namaSekolah'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idSekolah': idSekolahModel,
      'alamatSekolah': alamatSekolahModel,
      'keterangan': keteranganModel,
      'namaSekolah': namaSekolahModel,
    };
  }

  Sekolah toEntity() {
    return Sekolah(
      idSekolah: idSekolahModel,
      alamatSekolah: alamatSekolahModel,
      keterangan: keteranganModel,
      namaSekolah: namaSekolahModel,
    );
  }
}

class StatusModel extends Equatable {
  final int? idStatusModel;
  final String? statusModel;

  const StatusModel({this.idStatusModel, this.statusModel});

  @override
  List<Object?> get props => [idStatusModel, statusModel];

  factory StatusModel.fromEntity(Status entity) {
    return StatusModel(
      idStatusModel: entity.idStatus,
      statusModel: entity.status,
    );
  }

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      idStatusModel: json['idStatus'],
      statusModel: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'idStatus': idStatusModel, 'status': statusModel};
  }

  Status toEntity() {
    return Status(idStatus: idStatusModel, status: statusModel);
  }
}

class WaktuKuliahModel extends Equatable {
  final int? idWaktuKuliahModel;
  final String? waktuKuliahModel;
  final String? keteranganModel;

  const WaktuKuliahModel({
    this.idWaktuKuliahModel,
    this.waktuKuliahModel,
    this.keteranganModel,
  });

  @override
  List<Object?> get props => [
    idWaktuKuliahModel,
    waktuKuliahModel,
    keteranganModel,
  ];

  factory WaktuKuliahModel.fromEntity(WaktuKuliah entity) {
    return WaktuKuliahModel(
      idWaktuKuliahModel: entity.idWaktuKuliah,
      waktuKuliahModel: entity.waktuKuliah,
      keteranganModel: entity.keterangan,
    );
  }

  factory WaktuKuliahModel.fromJson(Map<String, dynamic> json) {
    return WaktuKuliahModel(
      idWaktuKuliahModel: json['idWaktuKuliah'],
      waktuKuliahModel: json['waktuKuliah'],
      keteranganModel: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idWaktuKuliah': idWaktuKuliahModel,
      'waktuKuliah': waktuKuliahModel,
      'keterangan': keteranganModel,
    };
  }

  WaktuKuliah toEntity() {
    return WaktuKuliah(
      idWaktuKuliah: idWaktuKuliahModel,
      waktuKuliah: waktuKuliahModel,
      keterangan: keteranganModel,
    );
  }
}
