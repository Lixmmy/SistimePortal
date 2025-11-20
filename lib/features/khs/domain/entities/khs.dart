import 'package:equatable/equatable.dart';
import 'package:newsistime/features/transkrip/domain/entities/nilai.dart';

class Khs extends Equatable {
  final int idKrs;
  final String kodeMatakuliah;
  final String namaMatakuliah;
  final int semester;
  final int sks;
  final Nilai? nilais;
  final String? letterGrade;

  const Khs({
    required this.idKrs,
    required this.kodeMatakuliah,
    required this.namaMatakuliah,
    required this.semester,
    required this.sks,
    this.nilais,
    this.letterGrade,
  });

  Khs copyWith({
    int? idKrs,
    String? kodeMatakuliah,
    String? namaMatakuliah,
    int? sks,
    int? semester,
    Nilai? nilais,
    String? letterGrade,
  }) {
    return Khs(
      idKrs: idKrs ?? this.idKrs,
      kodeMatakuliah: kodeMatakuliah ?? this.kodeMatakuliah,
      namaMatakuliah: namaMatakuliah ?? this.namaMatakuliah,
      semester: semester ?? this.semester,
      sks: sks ?? this.sks,
      nilais: nilais ?? this.nilais,
      letterGrade: letterGrade ?? this.letterGrade,
    );
  }

  @override
  List<Object?> get props => [
    idKrs,
    kodeMatakuliah,
    namaMatakuliah,
    sks,
    semester,
    nilais,
    letterGrade,
  ];
}

class ListTranskrip extends Equatable {
  final List<Khs> transkrip;

  const ListTranskrip({required this.transkrip});

  @override
  List<Object?> get props => [transkrip];
}
