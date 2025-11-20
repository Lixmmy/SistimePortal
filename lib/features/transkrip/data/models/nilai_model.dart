import 'package:newsistime/features/transkrip/domain/entities/nilai.dart';

double? _parseDouble(dynamic value) {
  if (value is String) {
    return double.tryParse(value);
  } else if (value is num) {
    return value.toDouble();
  }
  return null;
}

class NilaiModel {
  final double? tugasModel;
  final double? utsModel;
  final double? uasModel;
  final double? absensiModel;
  final double? projectModel;
  final double? quizModel;
  final double? perbaikanModel;

  const NilaiModel({
    this.tugasModel,
    this.utsModel,
    this.uasModel,
    this.absensiModel,
    this.projectModel,
    this.quizModel,
    this.perbaikanModel,
  });

  factory NilaiModel.fromJson(Map<String, dynamic> json) {
    return NilaiModel(
      tugasModel: _parseDouble(json['tugas']),
      utsModel: _parseDouble(json['uts']),
      uasModel: _parseDouble(json['uas']),
      absensiModel: _parseDouble(json['absensi']),
      projectModel: _parseDouble(json['project']),
      quizModel: _parseDouble(json['quiz']),
      perbaikanModel: _parseDouble(json['perbaikan']),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tugasModel != null) {
      data['tugas'] = tugasModel;
    }
    if (utsModel != null) data['uts'] = utsModel;
    if (uasModel != null) data['uas'] = uasModel;
    if (absensiModel != null) data['absensi'] = absensiModel;
    if (projectModel != null) {
      data['project'] = projectModel;
    }
    if (quizModel != null) {
      data['quiz'] = quizModel;
    }
    if (perbaikanModel != null) {
      data['perbaikan'] = perbaikanModel;
    }
    return data;
  }

  Nilai toEntity() {
    return Nilai(
      tugas: tugasModel,
      uts: utsModel,
      uas: uasModel,
      absensi: absensiModel,
      project: projectModel,
      quiz: quizModel,
      perbaikan: perbaikanModel,
    );
  }
}