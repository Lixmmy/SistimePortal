import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';

abstract class TranskripRepositories {
  Future<Either<MessageExc, List<Transkrip>>> getTranskrip({required String nim});
}
