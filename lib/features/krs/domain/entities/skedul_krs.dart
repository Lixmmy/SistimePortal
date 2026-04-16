import 'package:equatable/equatable.dart';

class SkedulKrs extends Equatable {
  final int id;
  final int idSkemaKrs;
  final int idMataKuliah;
  final int idDosen;
  final String? keterangan;
  final String kodeKelas;

  const SkedulKrs({
    required this.id,
    required this.idDosen,
    required this.idMataKuliah,
    required this.idSkemaKrs,
    required this.kodeKelas,
    this.keterangan,
  });

  @override
  List<Object?> get props => [
    id,
    idDosen,
    idMataKuliah,
    idSkemaKrs,
    kodeKelas,
    keterangan,
  ];
}
