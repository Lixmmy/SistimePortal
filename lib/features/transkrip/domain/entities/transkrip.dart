import 'package:equatable/equatable.dart';
import 'package:newsistime/features/transkrip/domain/entities/nilai.dart';

class Transkrip extends Equatable {
  final int krsId;
  final String kodeMatkul;
  final String matkul;
  final int sks;
  final Nilai? nilai;
  final String? letterGrade;

  const Transkrip({
    required this.krsId,
    required this.kodeMatkul,
    required this.matkul,
    required this.sks,
    this.nilai,
    this.letterGrade,
  });

  Transkrip copyWith({
    int? krsId,
    String? kodeMatkul,
    String? matkul,
    int? sks,
    Nilai? nilai,
    String? letterGrade,
  }) {
    return Transkrip(
      krsId: krsId ?? this.krsId,
      kodeMatkul: kodeMatkul ?? this.kodeMatkul,
      matkul: matkul ?? this.matkul,
      sks: sks ?? this.sks,
      nilai: nilai ?? this.nilai,
      letterGrade: letterGrade ?? this.letterGrade,
    );
  }

  @override
  List<Object?> get props => [
    krsId,
    kodeMatkul,
    matkul,
    sks,
    nilai,
    letterGrade,
  ];
}

class ListTranskrip extends Equatable {
  final List<Transkrip> transkrip;

  const ListTranskrip({required this.transkrip});

  @override
  List<Object?> get props => [transkrip];
}
