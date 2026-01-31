import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/program_studi/domain/entities/program_studi.dart';

abstract class ProgramStudiRepositories {
  Future<Either<MessageExc, List<ProgramStudi>>> getProgramStudi();
}
