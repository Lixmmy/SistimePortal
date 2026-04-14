import 'package:newsistime/features/krs/domain/entities/skema_krs.dart';

class SkemaModel {
  final int idModel;
  final int idTahunAjaranModel;
  final bool aktifModel;
  final String? keteranganModel;

  const SkemaModel({
    required this.idModel,
    required this.idTahunAjaranModel,
    required this.aktifModel,
    this.keteranganModel,
  });

  factory SkemaModel.fromJson(Map<String, dynamic> json) {
    return SkemaModel(
      idModel: json['id'],
      idTahunAjaranModel: json['idTahunAjaran'],
      aktifModel: json['aktif'],
      keteranganModel: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idModel,
      'idTahunAjaran': idTahunAjaranModel,
      'aktif': aktifModel,
      'keterangan': keteranganModel,
    };
  }

  SkemaKrs toEntity() {
    return SkemaKrs(
      id: idModel,
      idTahunAjaran: idTahunAjaranModel,
      aktif: aktifModel,
      keterangan: keteranganModel,
    );
  }
}

class ListSkemaModel {
  final List<SkemaModel> listSkemaModel;

  const ListSkemaModel({required this.listSkemaModel});

  factory ListSkemaModel.fromJson(List<dynamic> json) {
    return ListSkemaModel(
      listSkemaModel: json.map((e) => SkemaModel.fromJson(e)).toList(),
    );
  }

  ListSkemaKrs toEntity() {
    return ListSkemaKrs(
      listSkema: listSkemaModel.map((e) => e.toEntity()).toList(),
    );
  }
}
