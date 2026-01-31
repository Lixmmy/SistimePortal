import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/status/domain/entities/status.dart';

abstract class StatusRepositories {
  Future<Either<MessageExc, List<Status>>> getStatus();
}
