import 'package:equatable/equatable.dart';

class Matkul extends Equatable {
  final int id;
  final String kodeMataKuliah;
  final String namaMataKuliah;
  final int sks;
  final int semester;
  final String tipeMataKuliah;
  final String? keterangan;

  const Matkul({
    required this.id,
    required this.tipeMataKuliah,
    required this.kodeMataKuliah,
    required this.namaMataKuliah,
    this.keterangan,
    required this.sks,
    required this.semester,
  });

  @override
  List<Object?> get props => [
    id,
    tipeMataKuliah,
    kodeMataKuliah,
    namaMataKuliah,
    keterangan,
    sks,
    semester,
  ];
}
