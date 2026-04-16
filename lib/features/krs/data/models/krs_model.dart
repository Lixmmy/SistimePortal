import 'package:newsistime/features/krs/domain/entities/krs.dart';

class KrsModel {
  final int idKrsModel;
  final int idSkemaKrsModel;
  final String kodeMatakuliahModel;
  final String namaMatakuliahModel;
  final String namaDosenModel;

  KrsModel({
    required this.idKrsModel,
    required this.idSkemaKrsModel,
    required this.kodeMatakuliahModel,
    required this.namaMatakuliahModel,
    required this.namaDosenModel,
  });

  factory KrsModel.fromJson(Map<String, dynamic> json) {
    return KrsModel(
      idKrsModel: json['idKrs'],
      idSkemaKrsModel: json['idSkemaKrs'],
      kodeMatakuliahModel: json['kodeMatakuliah'],
      namaMatakuliahModel: json['namaMatakuliah'],
      namaDosenModel: json['namaDosen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idKrs': idKrsModel,
      'idSkemaKrs': idSkemaKrsModel,
      'kodeMataKuliah': kodeMatakuliahModel,
      'namaMataKuliah': namaMatakuliahModel,
      'namaDosen': namaDosenModel,
    };
  }

  Krs toEntity() {
    return Krs(
      idKrs: idKrsModel,
      idSkemaKrs: idSkemaKrsModel,
      kodeMatakuliah: kodeMatakuliahModel,
      namaMatakuliah: namaMatakuliahModel,
      namaDosen: namaDosenModel,
      sks: 0, // Default value, will be updated in BLoC
    );
  }
}
