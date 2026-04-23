import 'package:equatable/equatable.dart';
import 'package:newsistime/features/dosen/domain/entities/dosen.dart';
import 'package:newsistime/features/krs/domain/entities/matkul.dart';

class JadwalKrs extends Equatable {
  final Matkul matkul;
  final Dosen dosen;
  final int tipeSkedul;
  final int idUser;

  const JadwalKrs({
    required this.matkul,
    required this.dosen,
    required this.tipeSkedul,
    required this.idUser,
  });
  @override
  List<Object?> get props => [matkul, dosen, tipeSkedul, idUser];
}
