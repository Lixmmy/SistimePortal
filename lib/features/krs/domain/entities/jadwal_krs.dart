import 'package:equatable/equatable.dart';
import 'package:sistime_portal/features/dosen/domain/entities/dosen.dart';
import 'package:sistime_portal/features/krs/domain/entities/matkul.dart';

class JadwalKrs extends Equatable {
  final Matkul matkul;
  final Dosen dosen;
  final int idSkedul;
  final int tipeSkedul;
  final int idUser;
  final String? keterangan;
  final String? kodeKelas;

  const JadwalKrs({
    required this.matkul,
    required this.dosen,
    required this.idSkedul,
    required this.tipeSkedul,
    required this.idUser,
    this.keterangan,
    this.kodeKelas,
  });
  @override
  List<Object?> get props => [
    matkul,
    dosen,
    tipeSkedul,
    idUser,
    idSkedul,
    keterangan,
    kodeKelas,
  ];
}
