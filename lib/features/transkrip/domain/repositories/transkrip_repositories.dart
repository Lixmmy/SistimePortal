import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/transkrip/domain/entities/transkrip.dart';

abstract class TranskripRepositories {
  Future<Either<MessageExc, List<Transkrip>>> getTranskrip({
    required String idUser,
  });
}
