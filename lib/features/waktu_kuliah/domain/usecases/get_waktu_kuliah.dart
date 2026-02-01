import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/waktu_kuliah/domain/entities/waktu_kuliah.dart';
import 'package:newsistime/features/waktu_kuliah/domain/repositories/waktu_kuliah_repositories.dart';

class GetWaktuKuliah {
  final WaktuKuliahRepositories waktuKuliahRepositories;

  const GetWaktuKuliah(this.waktuKuliahRepositories);
  Future<Either<MessageExc,List<WaktuKuliah>>> execute() async {
    return await waktuKuliahRepositories.getWaktuKuliahList();
  }
}