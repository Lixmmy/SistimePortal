import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/program_studi/domain/entities/program_studi.dart';

abstract class ProgramStudiRepositories {
  Future<Either<MessageExc, List<ProgramStudi>>> getProgramStudi();
}
