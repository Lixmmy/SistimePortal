import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../../domain/entities/profil.dart';
import '../../domain/repositories/profil_repository.dart';

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
      final Profil hasil = await profilRemoteDataSourceImplementation
          .getMahasiswa(nim);
      profilLocalDataSource.savedProfilData(hasil);
      return Right(hasil);
    } catch (e) {
      try {
        final localData = await profilLocalDataSource.getSavedProfilData();
        if (localData != null) {
          return Right(localData.toEntity());
        } else if (e is MessageExc) {
          return Left(e);
        } else {
          return Left(MessageExc.unknown(e.toString()));
        }
      } catch (_) {
        if (e is MessageExc) {
          return Left(e);
        } else {
          return Left(MessageExc.unknown(e.toString()));
        }
      }
    }
  }
}
