import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
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
  Future<Either<MessageExc, Profil>> getMahasiswa(String nim) async {
    try {
      final List<ConnectivityResult> connectivityPlus = await (Connectivity()
          .checkConnectivity());
      if (connectivityPlus.contains(ConnectivityResult.none)) {
        final localData = await profilLocalDataSource.getSavedProfilData();
        if (localData != null) {
          return Right(localData.toEntity());
        } else {
          return Left(MessageExc.api('No local data found'));
        }
      } else {
        final Profil hasil = await profilRemoteDataSourceImplementation.getMahasiswa(
          nim,
        );
        // profilLocalDataSource.savedProfilData(hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }
}
