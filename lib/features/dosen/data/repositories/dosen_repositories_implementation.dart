import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/dosen/data/datasources/dosen_remote_data_source.dart';
import 'package:sistime_portal/features/dosen/domain/entities/dosen.dart';
import 'package:sistime_portal/features/dosen/domain/repositories/dosen_repository.dart';

class DosenRepositoriesImplementation extends DosenRepository {
  final DosenRemoteDataSource remoteDataSource;

  DosenRepositoriesImplementation({required this.remoteDataSource});

  @override
  Future<Either<MessageExc, List<Dosen>>> getDosen() async {
    try {
      final response = await remoteDataSource.getDosen();
      return Right(response.map((e) => e.toEntity()).toList());
    } on MessageExc catch (e) {
      if (e.type == MessageExcType.tokenExpired) {
        return Left(e);
      } else {
        return Left(e);
      }
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }
}
