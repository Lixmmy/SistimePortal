import 'package:equatable/equatable.dart';

class StatusMahasiswa extends Equatable {
  final String kodeKelas;
  final String statusMahasiswa;

  const StatusMahasiswa({
    required this.kodeKelas,
    required this.statusMahasiswa,
  });

  @override
  List<Object?> get props => [kodeKelas, statusMahasiswa];
}
