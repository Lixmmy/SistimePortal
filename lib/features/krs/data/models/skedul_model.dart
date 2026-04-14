import 'package:newsistime/features/krs/domain/entities/skedul_krs.dart';

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

class ListSkedulModel {
  final List<SkedulModel> listSkedulModel;

  const ListSkedulModel({required this.listSkedulModel});

  factory ListSkedulModel.fromJson(List<dynamic> json) {
    return ListSkedulModel(
      listSkedulModel: json.map((e) => SkedulModel.fromJson(e)).toList(),
    );
  }

  ListSkedulKrs toEntity() {
    return ListSkedulKrs(
      listSkedul: listSkedulModel.map((e) => e.toEntity()).toList(),
    );
  }
}
