import 'package:newsistime/features/krs/domain/entities/matkul.dart';

class MatkulModel {
  final int idMatkulModel;
  final IdTipeMatakuliahModel idTipeMatakuliahModel;
  final String kodeMataKuliahModel;
  final String namaMataKuliahModel;
  final String? keteranganModel;
  final int sksModel;
  final int semesterModel;

  const MatkulModel({
    required this.idMatkulModel,
    required this.idTipeMatakuliahModel,
    required this.kodeMataKuliahModel,
    required this.namaMataKuliahModel,
    this.keteranganModel,
    required this.sksModel,
    required this.semesterModel,
  });

  factory MatkulModel.fromJson(Map<String, dynamic> json) {
    return MatkulModel(
      idMatkulModel: json['id'],
      idTipeMatakuliahModel: json['idTipematakuliah'],
      kodeMataKuliahModel: json['kodeMatakuliah'],
      namaMataKuliahModel: json['namaMatakuliah'],
      keteranganModel: json['keterangan'],
      sksModel: json['sks'],
      semesterModel: json['semester'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idMatkulModel,
      'idTipematakuliah': idTipeMatakuliahModel,
      'kodeMatakuliah': kodeMataKuliahModel,
      'namaMatakuliah': namaMataKuliahModel,
      'keterangan': keteranganModel,
      'sks': sksModel,
      'semester': semesterModel,
    };
  }

  Matkul toEntity() {
    return Matkul(
      id: idMatkulModel,
      idTipeMataKuliah: idTipeMatakuliahModel.toEntity(),
      kodeMataKuliah: kodeMataKuliahModel,
      namaMataKuliah: namaMataKuliahModel,
      keterangan: keteranganModel,
      sks: sksModel,
      semester: semesterModel,
    );
  }
}

class IdTipeMatakuliahModel {
  final int id;
  final String tipeMatakuliah;
  final String keterangan;

  const IdTipeMatakuliahModel({
    required this.id,
    required this.tipeMatakuliah,
    required this.keterangan,
  });

  factory IdTipeMatakuliahModel.fromEntity(IdTipeMatakuliah entity) {
    return IdTipeMatakuliahModel(
      id: entity.id,
      tipeMatakuliah: entity.tipeMatakuliah,
      keterangan: entity.keterangan,
    );
  }

  factory IdTipeMatakuliahModel.fromJson(Map<String, dynamic> json) {
    return IdTipeMatakuliahModel(
      id: json['id'],
      tipeMatakuliah: json['tipeMatakuliah'],
      keterangan: json['keterangan'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipeMatakuliah': tipeMatakuliah,
      'keterangan': keterangan,
    };
  }

  IdTipeMatakuliah toEntity() {
    return IdTipeMatakuliah(
      id: id,
      tipeMatakuliah: tipeMatakuliah,
      keterangan: keterangan,
    );
  }
}

class ListMatkulModel {
  final List<MatkulModel> listMatkulModel;

  const ListMatkulModel({required this.listMatkulModel});

  factory ListMatkulModel.fromJson(List<dynamic> json) {
    return ListMatkulModel(
      listMatkulModel: json.map((e) => MatkulModel.fromJson(e)).toList(),
    );
  }

  ListMatkul toEntity() {
    return ListMatkul(
      matkul: listMatkulModel.map((e) {
        return e.toEntity();
      }).toList(),
    );
  }
}
