import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/status_mahasiswa/data/datasources/status_mahasiswa_remote_data_source.dart';
import 'package:sistime_portal/features/status_mahasiswa/data/models/status_mahasiswa_model.dart';
import 'package:sistime_portal/features/status_mahasiswa/domain/entities/status_mahasiswa.dart';
import 'package:sistime_portal/features/status_mahasiswa/domain/repositories/status_mahasiswa_repository.dart';

class StatusMahasiswaRepositoryImplementation
    extends StatusMahasiswaRepository {
  final StatusMahasiswaRemoteDatasource statusMahasiswaRemoteDataSource;

  StatusMahasiswaRepositoryImplementation({
    required this.statusMahasiswaRemoteDataSource,
  });

  @override
  Future<Either<MessageExc, StatusMahasiswa>> getStatusMahasiswa(
    String idUser,
  ) async {
    try {
      final StatusMahasiswaModel result = await statusMahasiswaRemoteDataSource
          .getStatusMahasiswa(idUser);
      return Right(result.toEntity());
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }
}
