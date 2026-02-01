import 'package:equatable/equatable.dart';

class WaktuKuliah extends Equatable {
  final int idWaktuKuliah;
  final String kodeKampus;
  final String waktuKuliah;
  final String keterangan;

  const WaktuKuliah({
    required this.idWaktuKuliah,
    required this.kodeKampus,
    required this.waktuKuliah,
    required this.keterangan,
  });

  @override
  List<Object?> get props => [
        idWaktuKuliah,
        kodeKampus,
        waktuKuliah,
        keterangan,
      ];

}