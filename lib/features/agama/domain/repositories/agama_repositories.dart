import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/agama/domain/entities/agama.dart';

abstract class AgamaRepositories {
  Future<Either<MessageExc, List<Agama>>> getAgama();
}
