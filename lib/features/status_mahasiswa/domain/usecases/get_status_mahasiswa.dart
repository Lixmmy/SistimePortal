import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/status_mahasiswa/domain/entities/status_mahasiswa.dart';
import 'package:sistime_portal/features/status_mahasiswa/domain/repositories/status_mahasiswa_repository.dart';

class GetStatusMahasiswa {
  final StatusMahasiswaRepository repository;

  GetStatusMahasiswa({required this.repository});

  Future<Either<MessageExc, StatusMahasiswa>> call(String idUser) async {
    return await repository.getStatusMahasiswa(idUser);
  }
}
