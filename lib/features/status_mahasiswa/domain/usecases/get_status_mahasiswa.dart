import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/status_mahasiswa/domain/entities/status_mahasiswa.dart';
import 'package:newsistime/features/status_mahasiswa/domain/repositories/status_mahasiswa_repository.dart';

class GetStatusMahasiswa {
  final StatusMahasiswaRepository repository;

  GetStatusMahasiswa({required this.repository});

  Future<Either<MessageExc, StatusMahasiswa>> call(String idUser) async {
    return await repository.getStatusMahasiswa(idUser);
  }
}
