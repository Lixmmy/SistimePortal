import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/data/datasources/remote_krs_data_source.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/entities/matkul.dart';
import 'package:newsistime/features/krs/domain/repositories/krs_repositories.dart';

class KrsRepositoriesImplementation extends KrsRepositories {
  final RemoteKrsDataSource remoteKrsDataSource;

  KrsRepositoriesImplementation({required this.remoteKrsDataSource});

  @override
  Future<Either<MessageExc, List<Krs>>> getKrs({required String nim}) async {
    try {
      final List<Krs> krs = await remoteKrsDataSource.getKrs(nim: nim);
      return Right(krs);
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }

  @override
  Future<Either<MessageExc, List<Matkul>>> getMataKuliah() async {
    try {
      final List<Matkul> matkul = await remoteKrsDataSource.getMataKuliah();
      return Right(matkul);
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }
}
