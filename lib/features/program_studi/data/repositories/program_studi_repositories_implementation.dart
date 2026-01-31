import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/program_studi/data/datasource/program_studi_remote_data_source.dart';
import 'package:newsistime/features/program_studi/data/datasource/local_program_studi_data_source.dart';
import 'package:newsistime/features/program_studi/domain/entities/program_studi.dart';
import 'package:newsistime/features/program_studi/domain/repositories/program_studi_repositories.dart';

class ProgramStudiRepositoriesImplementation
    implements ProgramStudiRepositories {
  final ProgramStudiRemoteDataSource programStudiRemoteDataSource;
  final LocalProgramStudiDataSource localProgramStudiDataSource;

  ProgramStudiRepositoriesImplementation({
    required this.programStudiRemoteDataSource,
    required this.localProgramStudiDataSource,
  });

  @override
  Future<Either<MessageExc, List<ProgramStudi>>> getProgramStudi() async {
    try {
      final response = await programStudiRemoteDataSource.getProgramStudi();
      await localProgramStudiDataSource.savedProgramStudi(response);
      return Right(response.map((e) => e.toEntity()).toList());
    } catch (e) {
      try {
        final localData = await localProgramStudiDataSource
            .getSavedProgramStudi();
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
