import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/waktu_kuliah/domain/entities/waktu_kuliah.dart';

abstract class WaktuKuliahRepositories {
  Future<Either<MessageExc, List<WaktuKuliah>>> getWaktuKuliahList();
}
