import 'package:equatable/equatable.dart';

class Transkrip extends Equatable {
  final int krsId;
  final String kodeMatkul;
  final String matkul;
  final int sks;
  final Nilai? nilai;

  const Transkrip({
    required this.krsId,
    required this.kodeMatkul,
    required this.matkul,
    required this.sks,
    this.nilai,
  });

  @override
  List<Object?> get props => [krsId, kodeMatkul, matkul, sks, nilai];
}

class ListTranskrip extends Equatable {
  final List<Transkrip> transkrip;

  const ListTranskrip({required this.transkrip});

  @override
  List<Object?> get props => [transkrip];
}

class Nilai extends Equatable {
  final double tugas;
  final double uts;
  final double uas;
  final double absensi;
  final double? project;
  final double? quiz;


  const Nilai({required this.tugas, required this.uts, required this.uas, required this.absensi, this.project, this.quiz});

  @override
  List<Object?> get props => [tugas, uts, uas, absensi];
}
