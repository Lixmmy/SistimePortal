import 'package:dartz/dartz.dart';
import 'package:newsistime/features/profil/data/datasources/remote_datasource.dart';
import 'package:newsistime/features/profil/data/models/profil_model.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/profil.dart';
import '../../domain/repositories/profil_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProfilRepositoryImplementation extends ProfilRepository {
  final ProfilRemoteDataSourceImplementation profilRemoteDataSourceImplementation;

  ProfilRepositoryImplementation({
    required this.profilRemoteDataSourceImplementation,
  });
  @override
  Future<Either<Failure, Profil>> getMahasiswa(int nim) async {
    try{
    final List<ConnectivityResult> connectivityPlus = await (Connectivity()
        .checkConnectivity());
    if (connectivityPlus.contains(ConnectivityResult.none)) {
      return Left(Failure());
    } else {
      ProfilModel hasil = await profilRemoteDataSourceImplementation
          .getMahasiswa(nim);
      return Right(hasil);
    }
    }catch(e){
      return Left(Failure());
    }
  }
}
