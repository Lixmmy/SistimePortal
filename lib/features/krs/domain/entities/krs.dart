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

