import 'package:sistime_portal/features/status_mahasiswa/domain/entities/status_mahasiswa.dart';

class StatusMahasiswaModel {
  final String statusMahasiswa;
  final String kodeKelas;

  StatusMahasiswaModel({
    required this.statusMahasiswa,
    required this.kodeKelas,
  });

  factory StatusMahasiswaModel.fromJson(Map<String, dynamic> json) {
    return StatusMahasiswaModel(
      statusMahasiswa: json['status'],
      kodeKelas: json['kodeKelas'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'status': statusMahasiswa, 'kodeKelas': kodeKelas};
  }

  StatusMahasiswa toEntity() {
    return StatusMahasiswa(
      statusMahasiswa: statusMahasiswa,
      kodeKelas: kodeKelas,
    );
  }
}
