import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/status/data/datasource/status_remote_data_source.dart';
import 'package:newsistime/features/status/domain/entities/status.dart';
import 'package:newsistime/features/status/domain/repositories/status_repositories.dart';
import 'package:newsistime/features/status/data/datasource/status_local_data_source.dart';

class StatusRepositoriesImplementation implements StatusRepositories {
  final StatusLocalDataSource statusLocalDataSource;
  final StatusRemoteDataSource statusRemoteDataSource;

  StatusRepositoriesImplementation({
    required this.statusLocalDataSource,
    required this.statusRemoteDataSource,
  });

  @override
  Future<Either<MessageExc, List<Status>>> getStatus() async {
    try {
      final remoteData = await statusRemoteDataSource.getStatus();
      await statusLocalDataSource.savedStatus(remoteData);
      return Right(remoteData.map((e) => e.toEntity()).toList());
    } catch (e) {
      try {
        final localData = await statusLocalDataSource.getSavedStatus();
        if (localData.isEmpty) {
          return Left(MessageExc.api('No data found'));
        }
        return Right(localData.map((e) => e.toEntity()).toList());
      } catch (_) {
        return Left(MessageExc.api('No data found'));
      }
    }
  }
}
