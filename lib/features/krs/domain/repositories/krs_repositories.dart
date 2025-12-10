import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
// import 'package:newsistime/features/krs/domain/entities/matkul.dart';

abstract class KrsRepositories {
  Future<Either<MessageExc, List<Krs>>> getKrs({required String id});
  // Future<Either<MessageExc, List<Matkul>>> getMataKuliah();
}
