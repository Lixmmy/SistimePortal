import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/khs/data/datasources/remote_khs_data_source.dart';
import 'package:newsistime/features/khs/data/repositories/khs_repositories_implementation.dart';
import 'package:newsistime/features/khs/domain/repositories/khs_repositories.dart';
import 'package:newsistime/features/khs/domain/usecases/get_khs.dart';
import 'package:newsistime/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:newsistime/features/krs/data/datasources/remote_krs_data_source.dart';
import 'package:newsistime/features/krs/data/repositories/krs_repositories_implementation.dart';
import 'package:newsistime/features/krs/domain/repositories/krs_repositories.dart';
import 'package:newsistime/features/krs/domain/usecases/get_krs.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/features/language/data/datasources/language_local_data_source.dart';
import 'package:newsistime/features/language/data/repositories/app_language_repository_implementation.dart';
import 'package:newsistime/features/language/domain/repositories/app_language_repository.dart';
import 'package:newsistime/features/language/domain/usecases/get_current_local.dart';
import 'package:newsistime/features/language/domain/usecases/save_locale.dart';
import 'package:newsistime/features/language/presentation/bloc/language_bloc.dart';
import 'package:newsistime/features/login/data/datasources/login_remote_data_source.dart';
import 'package:newsistime/features/login/data/repositories/login_repositories_implementation.dart';
import 'package:newsistime/features/login/domain/repositories/login_repositories.dart';
import 'package:newsistime/features/login/domain/usecases/post_login_usecases.dart';
import 'package:newsistime/features/login/presentation/bloc/login_bloc.dart';
import 'package:newsistime/features/transkrip/data/datasources/remote_transkrip_data_source.dart';
import 'package:newsistime/features/transkrip/data/repositories/transkrip_repositories_implementation.dart';
import 'package:newsistime/features/transkrip/domain/repositories/transkrip_repositories.dart';
import 'package:newsistime/features/transkrip/domain/usecases/get_transkrip.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';
import 'core/helper/secure_storage.dart';
import 'features/profil/data/datasources/local_datasource.dart';
import 'features/profil/data/datasources/remote_datasource.dart';
import 'features/profil/data/repositories/profil_repository_implementation.dart';
import 'features/profil/domain/repositories/profil_repository.dart';
import 'features/profil/domain/usecases/get_mahasiswa.dart';
import 'features/profil/presentation/bloc/profil_bloc.dart';

final myInjection = GetIt.instance;

Future<void> init() async {
  //core-helper
  myInjection.registerLazySingleton(() => SecureStorage());
  myInjection.registerLazySingleton(() => InternetConnection());
  myInjection.registerLazySingleton(
    () => ConnectApi(secureStorage: myInjection()),
  );

  //Login Bloc
  myInjection.registerFactory(
    () => LoginBloc(postLoginUseCases: myInjection()),
  );
  //UseCases
  myInjection.registerLazySingleton(
    () => PostLoginUseCases(loginRepositories: myInjection()),
  );
  //Repositories
  myInjection.registerLazySingleton<LoginRepositories>(
    () => LoginRepositoriesImplementation(loginRemoteDataSource: myInjection()),
  );
  //DataSources
  myInjection.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(connectApi: myInjection()),
  );

  //Profil bloc
  myInjection.registerLazySingleton(
    () => ProfilBloc(getMahasiswa: myInjection()),
  );
  //usecases
  myInjection.registerLazySingleton(
    () => GetMahasiswa(profilRepo: myInjection(), secureStorage: myInjection()),
  );
  //repository
  myInjection.registerLazySingleton<ProfilRepository>(
    () => ProfilRepositoryImplementation(
      profilLocalDataSource: myInjection(),
      profilRemoteDataSourceImplementation: myInjection(),
    ),
  );
  //datasource
  myInjection.registerLazySingleton<ProfilRemoteDatasource>(
    () => ProfilRemoteDataSourceImplementation(connectApi: myInjection()),
  );
  myInjection.registerLazySingleton<ProfilLocalDataSource>(
    () => ProfilLocalDataSourceImplementation(myInjection()),
  );

  //Language bloc
  myInjection.registerFactory(
    // <--- GANTI INI
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

  //Transkrip bloc
  myInjection.registerLazySingleton(
    () => TranskripBloc(getTranskrip: myInjection(), profilBloc: myInjection()),
  );
  //Use cases
  myInjection.registerLazySingleton(
    () => GetTranskrip(transkripRepositories: myInjection()),
  );
  //Repository
  myInjection.registerLazySingleton<TranskripRepositories>(
    () => TranskripRepositoriesImplementation(
      remoteTranskripDataSource: myInjection(),
    ),
  );
  //Datasource
  myInjection.registerLazySingleton<RemoteTranskripDataSource>(
    () => RemoteTranskripDataSourceImplementation(connectApi: myInjection()),
  );

  //krs bloc
  myInjection.registerLazySingleton(
    () => KrsBloc(getKrs: myInjection(), profilBloc: myInjection()),
  );
  //Use cases
  myInjection.registerLazySingleton(
    () => GetKrs(krsRepositories: myInjection()),
  );
  //Repositories
  myInjection.registerLazySingleton<KrsRepositories>(
    () => KrsRepositoriesImplementation(remoteKrsDataSource: myInjection()),
  );
  //Datasource
  myInjection.registerLazySingleton<RemoteKrsDataSource>(
    () => RemoteKrsDataSourceImplementation(connectApi: myInjection()),
  );

  //khs bloc
  myInjection.registerLazySingleton(
    () => KhsBloc(getKhs: myInjection(), profilBloc: myInjection()),
  );
  //Use cases
  myInjection.registerLazySingleton(() => GetKhs(myInjection()));
  //Repositories
  myInjection.registerLazySingleton<KhsRepositories>(
    () => KhsRepositoriesImplementation(remoteKhsDataSource: myInjection()),
  );
  //Datasource
  myInjection.registerLazySingleton<RemoteKhsDataSource>(
    () => RemoteKhsDataSourceImplementation(connectApi: myInjection()),
  );
}
