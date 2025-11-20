
import 'package:equatable/equatable.dart';

class Nilai extends Equatable {
  final double? tugas;
  final double? uts;
  final double? uas;
  final double? absensi;
  final double? project;
  final double? quiz;
  final double? perbaikan;

  const Nilai({
    this.tugas,
    this.uts,
    this.uas,
    this.absensi,
    this.project,
    this.quiz,
    this.perbaikan,
  });

  @override
  List<Object?> get props => [tugas, uts, uas, absensi, project, quiz,perbaikan];
}
