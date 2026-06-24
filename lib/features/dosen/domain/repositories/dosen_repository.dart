import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/dosen/domain/entities/dosen.dart';

abstract class DosenRepository {
  Future<Either<MessageExc, List<Dosen>>> getDosen();
}
