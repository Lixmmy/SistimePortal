import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/waktu_kuliah/domain/entities/waktu_kuliah.dart';

abstract class WaktuKuliahRepositories {
  Future<Either<MessageExc,List<WaktuKuliah>>> getWaktuKuliahList();
}