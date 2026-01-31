import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/program_studi/domain/entities/program_studi.dart';
import 'package:newsistime/features/program_studi/domain/repositories/program_studi_repositories.dart';

class GetProgramStudi {
  final ProgramStudiRepositories programStudiRepositories;

  GetProgramStudi({required this.programStudiRepositories});

  Future<Either<MessageExc, List<ProgramStudi>>> execute() async {
    return await programStudiRepositories.getProgramStudi();
  }
}
