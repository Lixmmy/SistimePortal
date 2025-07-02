import 'package:get_it/get_it.dart';
import 'package:newsistime/features/language/data/datasources/language_local_data_source.dart';
import 'package:newsistime/features/language/data/repositories/app_language_repository_implementation.dart';
import 'package:newsistime/features/language/domain/repositories/app_language_repository.dart';
import 'package:newsistime/features/language/domain/usecases/get_current_local.dart';
import 'package:newsistime/features/language/domain/usecases/save_locale.dart';
import 'package:newsistime/features/language/presentation/bloc/language_bloc.dart';
import 'core/helper/secure_storage.dart';
import 'features/profil/data/datasources/local_datasource.dart';
import 'features/profil/data/datasources/remote_datasource.dart';
import 'features/profil/data/repositories/profil_repository_implementation.dart';
import 'features/profil/domain/repositories/profil_repository.dart';
import 'features/profil/domain/usecases/get_mahasiswa.dart';
import 'features/profil/presentation/bloc/profil_bloc.dart';

final myInjection = GetIt.instance;

Future<void> init() async {
  //bloc
  myInjection.registerFactory(() => ProfilBloc(getMahasiswa: myInjection()));

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

  myInjection.registerFactory(
    () => LanguageBloc(
      getCurrentLanguage: myInjection(),
      setLanguage: myInjection(),
    ),
  );

  // Use cases
  myInjection.registerLazySingleton(() => GetCurrentLocal(myInjection()));
  myInjection.registerLazySingleton(() => SaveLocale(myInjection()));

  // Repository
  myInjection.registerLazySingleton<AppLanguageRepository>(
    () => AppLanguageRepositoryImplementation(
      languageLocalDataSource: myInjection(),
    ),
  );

  // Data Sources
  myInjection.registerLazySingleton<LanguageLocalDataSource>(
    () => LanguageLocalDataSourceImpl(myInjection()),
  );
  myInjection.registerLazySingleton(() => SecureStorage());
}
