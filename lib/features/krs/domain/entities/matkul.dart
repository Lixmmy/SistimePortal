import 'package:equatable/equatable.dart';

class Matkul extends Equatable {
  final int id;
  final String kodeMataKuliah;
  final String namaMataKuliah;
  final int sks;
  final int semester;
  final dynamic kodeProdi;
  final IdTipeMatakuliah idTipeMataKuliah;
  final String? keterangan;

  const Matkul({
    required this.id,
    required this.idTipeMataKuliah,
    required this.kodeMataKuliah,
    required this.namaMataKuliah,
    required this.kodeProdi,
    this.keterangan,
    required this.sks,
    required this.semester,
  });

  @override
  List<Object?> get props => [
    id,
    idTipeMataKuliah,
    kodeMataKuliah,
    namaMataKuliah,
    keterangan,
    sks,
    semester,
  ];
}

class IdTipeMatakuliah extends Equatable {
  final int id;
  final String tipeMatakuliah;
  final String? keterangan;

  const IdTipeMatakuliah({
    required this.id,
    required this.tipeMatakuliah,
    this.keterangan,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipeMatakuliah': tipeMatakuliah,
      'keterangan': keterangan ?? '',
    };
  }

  factory IdTipeMatakuliah.fromJson(Map<String, dynamic> json) {
    return IdTipeMatakuliah(
      id: json['id'],
      tipeMatakuliah: json['tipeMatakuliah'],
      keterangan: json['keterangan'],
    );
  }
  @override
  List<Object?> get props => [id, tipeMatakuliah, keterangan];
}

class ListMatkul extends Equatable {
  final List<Matkul> matkul;

  const ListMatkul({required this.matkul});

  @override
  List<Object?> get props => [matkul];
}
