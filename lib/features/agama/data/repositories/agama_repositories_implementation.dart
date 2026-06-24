import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/agama/domain/entities/agama.dart';
import 'package:sistime_portal/features/agama/domain/repositories/agama_repositories.dart';

import '../datasources/agama_local_data_source.dart';
import '../datasources/agama_remote_data_source.dart';

class AgamaRepositoriesImplementation implements AgamaRepositories {
  final AgamaRemoteDataSource agamaRemoteDataSource;
  final AgamaLocalDataSource agamaLocalDataSource;
  AgamaRepositoriesImplementation({
    required this.agamaRemoteDataSource,
    required this.agamaLocalDataSource,
  });

  @override
  Future<Either<MessageExc, List<Agama>>> getAgama() async {
    try {
      final remoteData = await agamaRemoteDataSource.getAgama();
      await agamaLocalDataSource.savedAgama(remoteData);
      return Right(remoteData.map((e) => e.toEntity()).toList());
    } catch (e) {
      try {
        final localData = await agamaLocalDataSource.getSavedAgama();
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
