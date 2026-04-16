import 'package:equatable/equatable.dart';

class SkemaKrs extends Equatable {
  final int id;
  final int idTahunAjaran;
  final bool aktif;
  final String? keterangan;

  const SkemaKrs({
    required this.id,
    required this.idTahunAjaran,
    required this.aktif,
    this.keterangan,
  });

  @override
  List<Object?> get props => [id, idTahunAjaran, aktif, keterangan];
}
