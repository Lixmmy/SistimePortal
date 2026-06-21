import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/status/domain/entities/status.dart';

abstract class StatusRepositories {
  Future<Either<MessageExc, List<Status>>> getStatus();
}
