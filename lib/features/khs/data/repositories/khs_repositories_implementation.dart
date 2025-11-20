import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/khs/data/datasources/remote_khs_data_source.dart';
import 'package:newsistime/features/khs/domain/entities/khs.dart';
import 'package:newsistime/features/khs/domain/repositories/khs_repositories.dart';

class KhsRepositoriesImplementation extends KhsRepositories {
  final RemoteKhsDataSource remoteKhsDataSource;

  KhsRepositoriesImplementation({required this.remoteKhsDataSource});

  @override
  Future<Either<MessageExc, List<Khs>>> getKhs({required String nim}) async {
    try {
      final List<Khs> khs = await remoteKhsDataSource.getKhs(nim: nim);
      return Right(khs);
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }

}