import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/waktu_kuliah/domain/entities/waktu_kuliah.dart';
import 'package:sistime_portal/features/waktu_kuliah/domain/repositories/waktu_kuliah_repositories.dart';

class GetWaktuKuliah {
  final WaktuKuliahRepositories waktuKuliahRepositories;

  const GetWaktuKuliah(this.waktuKuliahRepositories);
  Future<Either<MessageExc, List<WaktuKuliah>>> execute() async {
    return await waktuKuliahRepositories.getWaktuKuliahList();
  }
}
