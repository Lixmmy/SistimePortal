import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/khs/domain/entities/khs.dart';

abstract class KhsRepositories {
  Future<Either<MessageExc, List<Khs>>> getKhs({required String nim});
}
