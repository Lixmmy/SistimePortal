import 'package:dartz/dartz.dart';
import 'package:newsistime/features/dosen/domain/entities/dosen.dart';

abstract class DosenRepository {
  Future<Either<String, List<Dosen>>> getDosen();
}
