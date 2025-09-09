import 'package:newsistime/features/krs/domain/entities/krs.dart';

class KrsModel {
  final int idKrsModel;
  final int idSkemaKrsModel;
  final String kodeMatakuliahModel;
  final String namaMatakuliahModel;
  final String namaDosenModel;
  final int sksModel;

  KrsModel({
    required this.idKrsModel,
    required this.idSkemaKrsModel,
    required this.kodeMatakuliahModel,
    required this.namaMatakuliahModel,
    required this.namaDosenModel,
    required this.sksModel,
  });

  factory KrsModel.fromJson(Map<String, dynamic> json) {
    return KrsModel(
      idKrsModel: json['idKrs'],
      idSkemaKrsModel: json['idSkemaKrs'],
      kodeMatakuliahModel: json['kodeMataKuliah'],
      namaMatakuliahModel: json['namaMataKuliah'],
      namaDosenModel: json['namaDosen'],
      sksModel: json['sks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idKrs': idKrsModel,
      'idSkemaKrs': idSkemaKrsModel,
      'kodeMataKuliah': kodeMatakuliahModel,
      'namaMataKuliah': namaMatakuliahModel,
      'namaDosen': namaDosenModel,
      'sks': sksModel,
    };
  }

  Krs toEntitiy() {
    return Krs(
      idKrs: idKrsModel,
      idSkemaKrs: idSkemaKrsModel,
      kodeMatakuliah: kodeMatakuliahModel,
      namaMatakuliah: namaMatakuliahModel,
      namaDosen: namaDosenModel,
      sks: sksModel,
    );
  }
}
