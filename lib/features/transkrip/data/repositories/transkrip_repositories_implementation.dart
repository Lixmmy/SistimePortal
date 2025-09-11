import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/transkrip/data/datasources/remote_transkrip_data_source.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/features/transkrip/domain/repositories/transkrip_repositories.dart';

class TranskripRepositoriesImplementation extends TranskripRepositories {
  final RemoteTranskripDataSource remoteTranskripDataSource;

  TranskripRepositoriesImplementation({
    required this.remoteTranskripDataSource,
  });

  @override
  Future<Either<MessageExc, List<Transkrip>>> getTranskrip({
    required String nim,
  }) async {
    try {
      final List<Transkrip> transkrip =
          await remoteTranskripDataSource.getTranskrip(nim: nim);
      return Right(transkrip);
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }
}
