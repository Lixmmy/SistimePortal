import 'package:newsistime/features/krs/domain/entities/tahun_ajaran.dart';

class TahunAjaranModel {
  final int id;
  final int tahun;
  final String semester;
  final bool aktif;
  final String? keterangan;

  TahunAjaranModel({
    required this.id,
    required this.tahun,
    required this.semester,
    required this.aktif,
    this.keterangan,
  });

  factory TahunAjaranModel.fromJson(Map<String, dynamic> json) {
    return TahunAjaranModel(
      id: json['id'],
      tahun: json['tahun'],
      semester: json['semester'],
      aktif: json['aktif'],
      keterangan: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tahun': tahun,
      'semester': semester,
      'aktif': aktif,
      'keterangan': keterangan,
    };
  }

  TahunAjaran toEntity() {
    return TahunAjaran(
      id: id,
      tahun: tahun,
      semester: semester,
      aktif: aktif,
      keterangan: keterangan,
    );
  }
}
