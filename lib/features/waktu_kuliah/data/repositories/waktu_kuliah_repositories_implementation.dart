import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/waktu_kuliah/data/datasources/waktu_kuliah_local_data_source.dart';
import 'package:sistime_portal/features/waktu_kuliah/data/datasources/waktu_kuliah_remote_data_source.dart';
import 'package:sistime_portal/features/waktu_kuliah/domain/entities/waktu_kuliah.dart';
import 'package:sistime_portal/features/waktu_kuliah/domain/repositories/waktu_kuliah_repositories.dart';

class WaktuKuliahRepositoriesImplementation extends WaktuKuliahRepositories {
  final WaktuKuliahLocalDataSource localDataSource;
  final WaktuKuliahRemoteDataSource remoteDataSource;

  WaktuKuliahRepositoriesImplementation({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<MessageExc, List<WaktuKuliah>>> getWaktuKuliahList() async {
    try {
      final waktuKuliahModels = await remoteDataSource.getWaktuKuliahList();
      final waktuKuliahEntities = waktuKuliahModels
          .map((model) => model.toEntity())
          .toList();
      await localDataSource.savedWaktuKuliah(waktuKuliahModels);
      return Right(waktuKuliahEntities);
    } catch (e) {
      try {
        final localData = await localDataSource.getSavedWaktuKuliah();
        if (localData.isEmpty) {
          return Left(MessageExc.api('No data found'));
        }
        return Right(localData.map((e) => e.toEntity()).toList());
      } catch (_) {
        return Left(MessageExc.api('No data found'));
      }
    }
  }
}
