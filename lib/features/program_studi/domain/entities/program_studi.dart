import 'package:equatable/equatable.dart';

class ProgramStudi extends Equatable {
  final String kodeProgramstudi;
  final String? keterangan;
  final String namaProgramstudi;

  const ProgramStudi({
    required this.kodeProgramstudi,
    required this.keterangan,
    required this.namaProgramstudi,
  });

  @override
  List<Object?> get props => [kodeProgramstudi, keterangan, namaProgramstudi];
}
