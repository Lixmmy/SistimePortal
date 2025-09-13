import 'package:equatable/equatable.dart';

class Krs extends Equatable {
  final int idKrs;
  final int idSkemaKrs;
  final String kodeMatakuliah;
  final String namaMatakuliah;
  final String namaDosen;
  final int sks;
  const Krs({
    required this.idKrs,
    required this.idSkemaKrs,
    required this.kodeMatakuliah,
    required this.namaMatakuliah,
    required this.namaDosen,
    required this.sks,
  });

  @override
  List<Object?> get props => [
    idKrs,
    idSkemaKrs,
    kodeMatakuliah,
    namaMatakuliah,
    namaDosen,
    sks,
  ];
}

class ListKrs extends Equatable {
  final List<Krs> krs;

  const ListKrs({required this.krs});

  @override
  List<Object?> get props => [krs];
}

class Matkul extends Equatable {
  final int id;
  final int idTipeMataKuliah;
  final String kodeMataKuliah;
  final String namaMataKuliah;
  final String? keterangan;
  final int sks;
  final int semester;

  const Matkul({
    required this.id,
    required this.idTipeMataKuliah,
    required this.kodeMataKuliah,
    required this.namaMataKuliah,
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

class ListMatkul extends Equatable {
  final List<Matkul> matkul;

  const ListMatkul({required this.matkul});

  @override
  List<Object?> get props => [matkul];
}