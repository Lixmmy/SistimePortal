import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/status_mahasiswa/domain/entities/status_mahasiswa.dart';

abstract class StatusMahasiswaRepository {
  Future<Either<MessageExc, StatusMahasiswa>> getStatusMahasiswa(String idUser);
}
