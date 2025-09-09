import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';

abstract class KrsRepositories {
  Future <Either<MessageExc,List<Krs>>> getKrs();
}