import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/dosen/domain/entities/dosen.dart';

abstract class DosenRepository {
  Future<Either<MessageExc, List<Dosen>>> getDosen();
}
