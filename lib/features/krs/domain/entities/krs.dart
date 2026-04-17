import 'package:equatable/equatable.dart';

class Krs extends Equatable {
  final int id;
  final int idUser;
  final int idSkedul;
  final int tipeSkedul;
  final String? keterangan;

  const Krs({
    required this.id,
    required this.idUser,
    required this.idSkedul,
    required this.tipeSkedul,
    this.keterangan,
  });

  @override
  List<Object?> get props => [id, idUser, idSkedul, tipeSkedul, keterangan];
}
