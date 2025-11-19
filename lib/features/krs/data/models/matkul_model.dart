import 'package:newsistime/features/krs/domain/entities/matkul.dart';
import 'package:newsistime/features/profil/data/models/biodata_kampus_model.dart';

class MatkulModel {
  final int id;
  final String kodeMataKuliahModel;
  final String namaMataKuliahModel;
  final IdTipeMatakuliahModel idTipeMatakuliahModel;
  final dynamic kodeProdiModel;
  final String? keteranganModel;
  final int sksModel;
  final int semesterModel;

  const MatkulModel({
    required this.id,
    required this.idTipeMatakuliahModel,
    required this.kodeMataKuliahModel,
    required this.namaMataKuliahModel,
    required this.kodeProdiModel,
    this.keteranganModel,
    required this.sksModel,
    required this.semesterModel,
  });

  factory MatkulModel.fromJson(Map<String, dynamic> json) {
    dynamic parsedKodeProdi;
    if (json['kodeProdi'] is Map<String, dynamic>) {
      parsedKodeProdi = ProgramStudiModel.fromJson(json['kodeProdi']);
    } else if (json['kodeProdi'] is String) {
      parsedKodeProdi = json['kodeProdi'] as String;
    } else {
      parsedKodeProdi = null;
    }
    return MatkulModel(
      id: json['id'],
      idTipeMatakuliahModel: IdTipeMatakuliahModel.fromJson(
        json['idTipematakuliah'],
      ),
      kodeMataKuliahModel: json['kodeMatakuliah'],
      namaMataKuliahModel: json['namaMatakuliah'],
      kodeProdiModel: parsedKodeProdi,
      keteranganModel: json['keterangan'],
      sksModel: json['sks'],
      semesterModel: json['semester'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idTipematakuliah': idTipeMatakuliahModel,
      'kodeMatakuliah': kodeMataKuliahModel,
      'namaMatakuliah': namaMataKuliahModel,
      'keterangan': keteranganModel,
      'kodeProdi': kodeProdiModel,
      'sks': sksModel,
      'semester': semesterModel,
    };
  }

  Matkul toEntity() {
    dynamic prodi;
    if (kodeProdiModel is ProgramStudiModel) {
      prodi = kodeProdiModel.toEntity();
    } else if (kodeProdiModel is String) {
      prodi = kodeProdiModel;
    } else {
      prodi = null;
    }
    return Matkul(
      id: id,
      kodeProdi: prodi,
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
  final String? keterangan;

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
