import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/khs/domain/entities/khs.dart';

abstract class KhsRepositories {
  Future<Either<MessageExc, List<Khs>>> getKhs({required String id});
}
