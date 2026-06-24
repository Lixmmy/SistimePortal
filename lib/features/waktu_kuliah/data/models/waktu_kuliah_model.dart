import 'package:sistime_portal/features/waktu_kuliah/domain/entities/waktu_kuliah.dart';

class WaktuKuliahModel {
  final int idWaktuKuliah;
  final String kodeKampus;
  final String waktuKuliah;
  final String keterangan;
  WaktuKuliahModel({
    required this.idWaktuKuliah,
    required this.kodeKampus,
    required this.waktuKuliah,
    required this.keterangan,
  });

  factory WaktuKuliahModel.fromJson(Map<String, dynamic> json) {
    return WaktuKuliahModel(
      idWaktuKuliah: json['idWaktukuliah'],
      kodeKampus: json['kodeKampus'],
      waktuKuliah: json['waktuKuliah'],
      keterangan: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idWaktukuliah': idWaktuKuliah,
      'kodeKampus': kodeKampus,
      'waktuKuliah': waktuKuliah,
      'keterangan': keterangan,
    };
  }

  WaktuKuliah toEntity() {
    return WaktuKuliah(
      idWaktuKuliah: idWaktuKuliah,
      kodeKampus: kodeKampus,
      waktuKuliah: waktuKuliah,
      keterangan: keterangan,
    );
  }
}
