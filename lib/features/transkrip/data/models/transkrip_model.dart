import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';

class TranskripModel {
  final int krsIdModel;
  final String kodeMatkulModel;
  final String matkulModel;
  final int sksModel;
  final NilaiModel? nilaiModel;

  const TranskripModel({
    required this.krsIdModel,
    required this.kodeMatkulModel,
    required this.matkulModel,
    required this.sksModel,
    this.nilaiModel,
  });

  factory TranskripModel.fromJson(Map<String, dynamic> json) {
    return TranskripModel(
      krsIdModel: json['krsId'],
      kodeMatkulModel: json['kodeMatkul'],
      matkulModel: json['matkul'],
      sksModel: json['sks'],
      nilaiModel: json['nilais'] != null
          ? NilaiModel.fromJson(json['nilais'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['krsId'] = krsIdModel;
    data['kodeMatkul'] = kodeMatkulModel;
    data['matkul'] = matkulModel;
    data['sks'] = sksModel;
    if (nilaiModel != null) {
      data['nilais'] = nilaiModel!.toJson();
    }
    return data;
  }

  Transkrip toEntity() {
    return Transkrip(
      krsId: krsIdModel,
      kodeMatkul: kodeMatkulModel,
      matkul: matkulModel,
      sks: sksModel,
      nilai: nilaiModel?.toEntity(),
    );
  }
}

class ListTranskripModel {
  final List<TranskripModel> listTranskripModel;
  const ListTranskripModel({required this.listTranskripModel});

  factory ListTranskripModel.fromJson(List<dynamic> json) {
    return ListTranskripModel(
      listTranskripModel: json.map((e) => TranskripModel.fromJson(e)).toList(),
    );
  }

  ListTranskrip toEntity() {
    return ListTranskrip(
      transkrip: listTranskripModel.map((e) => e.toEntity()).toList(),
    );
  }
}

class NilaiModel {
  final double? tugasModel;
  final double? utsModel;
  final double? uasModel;
  final double? absensiModel;
  final double? projectModel;
  final double? quizModel;

  const NilaiModel({
    this.tugasModel,
    this.utsModel,
    this.uasModel,
    this.absensiModel,
    this.projectModel,
    this.quizModel,
  });

  factory NilaiModel.fromJson(Map<String, dynamic> json) {
    return NilaiModel(
      tugasModel: json['tugas'],
      utsModel: json['uts'],
      uasModel: json['uas'],
      absensiModel: json['absensi'],
      projectModel: json['project'],
      quizModel: json['quiz'],
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
    );
  }
}
