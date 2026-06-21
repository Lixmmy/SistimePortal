import 'package:sistime_portal/features/krs/domain/entities/skedul_krs.dart';

class SkedulModel {
  final int idModel;
  final int idSkemaKrsModel;
  final int idMataKuliahModel;
  final int idDosenModel;
  final String? keteranganModel;
  final String kodeKelasModel;

  const SkedulModel({
    required this.idModel,
    required this.idSkemaKrsModel,
    required this.idMataKuliahModel,
    required this.idDosenModel,
    required this.kodeKelasModel,
    this.keteranganModel,
  });

  factory SkedulModel.fromJson(Map<String, dynamic> json) {
    return SkedulModel(
      idModel: json['id'],
      idSkemaKrsModel: json['idSkemaKrs'],
      idMataKuliahModel: json['idMataKuliah'],
      idDosenModel: json['idDosen'],
      kodeKelasModel: json['kodeKelas'],
      keteranganModel: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idModel,
      'idSkemaKrs': idSkemaKrsModel,
      'idMataKuliah': idMataKuliahModel,
      'idDosen': idDosenModel,
      'kodeKelas': kodeKelasModel,
      'keterangan': keteranganModel,
    };
  }

  SkedulKrs toEntity() {
    return SkedulKrs(
      id: idModel,
      idSkemaKrs: idSkemaKrsModel,
      idMataKuliah: idMataKuliahModel,
      idDosen: idDosenModel,
      kodeKelas: kodeKelasModel,
      keterangan: keteranganModel,
    );
  }
}
