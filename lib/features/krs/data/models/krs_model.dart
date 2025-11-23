import 'package:newsistime/features/krs/domain/entities/krs.dart';

class KrsModel {
  final int idKrsModel;
  final int idSkemaKrsModel;
  final String kodeMatakuliahModel;
  final int semesterModel;
  final String namaMatakuliahModel;
  final String namaDosenModel;

  KrsModel({
    required this.idKrsModel,
    required this.idSkemaKrsModel,
    required this.semesterModel,
    required this.kodeMatakuliahModel,
    required this.namaMatakuliahModel,
    required this.namaDosenModel,
  });

  factory KrsModel.fromJson(Map<String, dynamic> json) {
    return KrsModel(
      idKrsModel: json['idKrs'],
      idSkemaKrsModel: json['idSkemaKrs'],
      semesterModel: json['semester'],
      kodeMatakuliahModel: json['kodeMatakuliah'],
      namaMatakuliahModel: json['namaMatakuliah'],
      namaDosenModel: json['namaDosen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idKrs': idKrsModel,
      'idSkemaKrs': idSkemaKrsModel,
      'semester': semesterModel,
      'kodeMataKuliah': kodeMatakuliahModel,
      'namaMataKuliah': namaMatakuliahModel,
      'namaDosen': namaDosenModel,
    };
  }

  Krs toEntity() {
    return Krs(
      idKrs: idKrsModel,
      idSkemaKrs: idSkemaKrsModel,
      semester: semesterModel,
      kodeMatakuliah: kodeMatakuliahModel,
      namaMatakuliah: namaMatakuliahModel,
      namaDosen: namaDosenModel,
      sks: 0, // Default value, will be updated in BLoC
    );
  }
}

class ListKrsModel {
  final List<KrsModel> listKrsModel;

  const ListKrsModel({required this.listKrsModel});

  factory ListKrsModel.fromJson(List<dynamic> json) {
    return ListKrsModel(
      listKrsModel: json.map((e) => KrsModel.fromJson(e)).toList(),
    );
  }

  ListKrs toEntity() {
    return ListKrs(
      krs: listKrsModel.map((e) {
        return e.toEntity();
      }).toList(),
    );
  }
}
