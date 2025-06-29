import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/failure.dart';
import 'package:newsistime/features/profil/data/datasources/local_datasource.dart';
import 'package:newsistime/features/profil/data/datasources/remote_datasource.dart';
import 'package:newsistime/features/profil/data/models/profil_model.dart';
import '../../domain/entities/profil.dart';
import '../../domain/repositories/profil_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProfilRepositoryImplementation extends ProfilRepository {
  final ProfilRemoteDatasource profilRemoteDataSourceImplementation;
  final ProfilLocalDataSource profilLocalDataSource;

  ProfilRepositoryImplementation({
    required this.profilLocalDataSource,
    required this.profilRemoteDataSourceImplementation,
  });
  @override
  Future<Either<Failure, Profil>> getMahasiswa(String nim) async {
    try {
      final List<ConnectivityResult> connectivityPlus = await (Connectivity()
          .checkConnectivity());
      if (connectivityPlus.contains(ConnectivityResult.none)) {
        final localData = await profilLocalDataSource
            .getSavedProfilData(); 
        if (localData != null) {
          return Right(localData);
        } else {
          return Left(Failure());
        }
      } else {
        ProfilModel hasil = await profilRemoteDataSourceImplementation
            .getMahasiswa(nim);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
