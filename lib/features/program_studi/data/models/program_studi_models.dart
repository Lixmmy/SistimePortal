import 'package:sistime_portal/features/program_studi/domain/entities/program_studi.dart';

class ProgramStudiModel {
  final String kodeProgramstudi;
  final String? keterangan;
  final String namaProgramstudi;

  const ProgramStudiModel({
    required this.kodeProgramstudi,
    required this.keterangan,
    required this.namaProgramstudi,
  });

  factory ProgramStudiModel.fromJson(Map<String, dynamic> json) =>
      ProgramStudiModel(
        kodeProgramstudi: json["kodeProgramstudi"],
        keterangan: json["keterangan"],
        namaProgramstudi: json["namaProgramstudi"],
      );

  Map<String, dynamic> toJson() => {
    "kodeProgramstudi": kodeProgramstudi,
    "keterangan": keterangan,
    "namaProgramstudi": namaProgramstudi,
  };

  ProgramStudi toEntity() {
    return ProgramStudi(
      kodeProgramstudi: kodeProgramstudi,
      keterangan: keterangan,
      namaProgramstudi: namaProgramstudi,
    );
  }
}
