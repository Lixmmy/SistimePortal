import 'package:newsistime/features/khs/domain/entities/khs.dart';
import 'package:newsistime/features/transkrip/data/models/nilai_model.dart';

class KhsModel {
  final int idKrsModel;
  final String kodeMatakuliahModel;
  final String namaMatakuliahModel;
  final int semesterModel;
  final int sksModel;
  final NilaiModel? nilaisModel;
  final String? letterGradeModel;

  const KhsModel({
    required this.idKrsModel,
    required this.kodeMatakuliahModel,
    required this.namaMatakuliahModel,
    required this.semesterModel,
    required this.sksModel,
    this.nilaisModel,
    this.letterGradeModel,
  });

  factory KhsModel.fromJson(Map<String, dynamic> json) {
    return KhsModel(
      idKrsModel: json['idKrs'],
      kodeMatakuliahModel: json['kodeMatakuliah'],
      namaMatakuliahModel: json['namaMatakuliah'],
      semesterModel: json['semester'],
      sksModel: json['sks'],
      nilaisModel: json['nilais'] != null
          ? NilaiModel.fromJson(json['nilais'])
          : null,
      letterGradeModel: json['letterGrade'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idKrs'] = idKrsModel;
    data['kodeMatakuliah'] = kodeMatakuliahModel;
    data['namaMatakuliah'] = namaMatakuliahModel;
    data['semester'] = semesterModel;
    data['sks'] = sksModel;
    if (nilaisModel != null) {
      data['nilais'] = nilaisModel!.toJson();
    }
    data['letterGrade'] = letterGradeModel;
    return data;
  }

  Khs toEntity() {
    return Khs(
      idKrs: idKrsModel,
      kodeMatakuliah: kodeMatakuliahModel,
      namaMatakuliah: namaMatakuliahModel,
      semester: semesterModel,
      sks: sksModel,
      nilais: nilaisModel?.toEntity(),
      letterGrade: letterGradeModel,
    );
  }
}

class ListKhsModel {
  final List<KhsModel> listKhsModel;
  const ListKhsModel({required this.listKhsModel});

  factory ListKhsModel.fromJson(List<dynamic> json) {
    return ListKhsModel(
      listKhsModel: json.map((e) => KhsModel.fromJson(e)).toList(),
    );
  }
  List<Khs> toEntity() {
    return listKhsModel.map((e) => e.toEntity()).toList();
  }
}
