import 'package:get_it/get_it.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/features/profil/data/datasources/local_datasource.dart';
import 'package:newsistime/features/profil/data/datasources/remote_datasource.dart';
import 'package:newsistime/features/profil/data/repositories/profil_repository_implementation.dart';
import 'package:newsistime/features/profil/domain/repositories/profil_repository.dart';
import 'package:newsistime/features/profil/domain/usecases/get_mahasiswa.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';

final myInjection = GetIt.instance;

Future<void> init() async {
  
  //bloc
  myInjection.registerFactory(()=> ProfilBloc(getMahasiswa: myInjection()));

  //usecases
  myInjection.registerLazySingleton(() => GetMahasiswa(myInjection()));
  //repository
  myInjection.registerLazySingleton<ProfilRepository>(
    () => ProfilRepositoryImplementation(
      profilLocalDataSource: myInjection(),
      profilRemoteDataSourceImplementation: myInjection(),
    ),
  );
  //datasource
  myInjection.registerLazySingleton<ProfilRemoteDatasource>(
    () => ProfilRemoteDataSourceImplementation(),
  );
 
  myInjection.registerLazySingleton<ProfilLocalDataSource>(
    () => ProfilLocalDataSourceImplementation(myInjection()),
  );

  //! External
  myInjection.registerLazySingleton(() => SecureStorage());
}
