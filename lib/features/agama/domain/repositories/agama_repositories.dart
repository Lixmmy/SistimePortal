import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/agama/domain/entities/agama.dart';

abstract class AgamaRepositories {
  Future<Either<MessageExc, List<Agama>>> getAgama();
}