import 'package:equatable/equatable.dart';

class Dosen extends Equatable {
  final String id;
  final String namaDosen;
  final String? statusDosen;
  final String? emailDosen;
  final String? noTelpDosen;
  final String? alamat;
  final String? keterangan;

  const Dosen({
    required this.id,
    required this.namaDosen,
    this.statusDosen,
    this.emailDosen,
    this.noTelpDosen,
    this.alamat,
    this.keterangan,
  });

  @override
  List<Object?> get props => [
    id,
    namaDosen,
    statusDosen,
    emailDosen,
    noTelpDosen,
    alamat,
    keterangan,
  ];
}
