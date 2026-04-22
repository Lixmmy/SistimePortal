import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/dosen/data/datasources/dosen_remote_data_source.dart';
import 'package:newsistime/features/dosen/domain/entities/dosen.dart';
import 'package:newsistime/features/dosen/domain/repositories/dosen_repository.dart';

class DosenRepositoriesImplementation extends DosenRepository {
  final DosenRemoteDataSource remoteDataSource;

  DosenRepositoriesImplementation({required this.remoteDataSource});

  @override
  Future<Either<String, List<Dosen>>> getDosen() async {
    try {
      final response = await remoteDataSource.getDosen();
      return Right(response.map((e) => e.toEntity()).toList());
    } on MessageExc catch (e) {
      if (e.type == MessageExcType.tokenExpired) {
        return Left(e.message);
      } else {
        return Left(e.message);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
