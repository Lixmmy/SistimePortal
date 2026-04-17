import 'package:equatable/equatable.dart';

class TahunAjaran extends Equatable {
  final int id;
  final int tahun;
  final String semester;
  final bool aktif;
  final String? keterangan;

  const TahunAjaran({
    required this.id,
    required this.tahun,
    required this.semester,
    required this.aktif,
    this.keterangan,
  });

  @override
  List<Object?> get props => [id, tahun, semester, aktif, keterangan];
}
