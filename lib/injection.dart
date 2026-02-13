import 'package:local_auth/local_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/agama/data/datasources/agama_local_data_source.dart';
import 'package:newsistime/features/agama/data/datasources/agama_remote_data_source.dart';
import 'package:newsistime/features/agama/data/repositories/agama_repositories_implementation.dart';
import 'package:newsistime/features/agama/domain/repositories/agama_repositories.dart';
import 'package:newsistime/features/agama/domain/usecases/get_agama.dart';
import 'package:newsistime/features/agama/presentation/bloc/agama_bloc.dart';
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
import 'package:newsistime/features/login/data/datasources/login_local_data_source.dart';
import 'package:newsistime/features/login/data/datasources/login_remote_data_source.dart';
import 'package:newsistime/features/login/data/repositories/login_repositories_implementation.dart';
import 'package:newsistime/features/login/domain/repositories/login_repositories.dart';
import 'package:newsistime/features/login/domain/usecases/log_out_usecases.dart';
import 'package:newsistime/features/login/domain/usecases/post_login_usecases.dart';
import 'package:newsistime/features/login/presentation/bloc/login_bloc.dart';
import 'package:newsistime/features/profil/domain/usecases/patch_mahasiswa.dart';
import 'package:newsistime/features/program_studi/data/datasource/local_program_studi_data_source.dart';
import 'package:newsistime/features/program_studi/data/datasource/program_studi_remote_data_source.dart';
import 'package:newsistime/features/program_studi/data/repositories/program_studi_repositories_implementation.dart';
import 'package:newsistime/features/program_studi/domain/repositories/program_studi_repositories.dart';
import 'package:newsistime/features/program_studi/domain/usescase/get_program_studi.dart';
import 'package:newsistime/features/status/data/datasource/status_local_data_source.dart';
import 'package:newsistime/features/status/data/datasource/status_remote_data_source.dart';
import 'package:newsistime/features/status/data/repositories/status_repositories_implementation.dart';
import 'package:newsistime/features/status/domain/repositories/status_repositories.dart';
import 'package:newsistime/features/status/domain/usescase/get_status.dart';
import 'package:newsistime/features/status/presentation/bloc/status_bloc.dart';
import 'package:newsistime/features/transkrip/data/datasources/remote_transkrip_data_source.dart';
import 'package:newsistime/features/transkrip/data/repositories/transkrip_repositories_implementation.dart';
import 'package:newsistime/features/transkrip/domain/repositories/transkrip_repositories.dart';
import 'package:newsistime/features/transkrip/domain/usecases/get_transkrip.dart';
import 'package:newsistime/features/transkrip/presentation/bloc/transkrip_bloc.dart';
import 'package:newsistime/features/waktu_kuliah/data/datasources/waktu_kuliah_local_data_source.dart';
import 'package:newsistime/features/waktu_kuliah/data/datasources/waktu_kuliah_remote_data_source.dart';
import 'package:newsistime/features/waktu_kuliah/data/repositories/waktu_kuliah_repositories_implementation.dart';
import 'package:newsistime/features/waktu_kuliah/domain/repositories/waktu_kuliah_repositories.dart';
import 'package:newsistime/features/waktu_kuliah/domain/usecases/get_waktu_kuliah.dart';
import 'package:newsistime/features/waktu_kuliah/presentation/bloc/waktu_kuliah_bloc.dart';
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
  myInjection.registerLazySingleton(() => LocalAuthentication()); // New
  myInjection.registerLazySingleton(
    () => ConnectApi(
      secureStorage: myInjection(),
      internetConnection: myInjection(),
    ),
  );

  //Login Bloc
  myInjection.registerFactory(
    () => LoginBloc(
      postLoginUseCases: myInjection(),
      loginLocalDataSource: myInjection(),
      localAuthentication: myInjection(), // New
    ),
  );
  //UseCases
  myInjection.registerLazySingleton(
    () => PostLoginUseCases(loginRepositories: myInjection()),
  );
  //Repositories
  myInjection.registerLazySingleton<LoginRepositories>(
    () => LoginRepositoriesImplementation(
      loginRemoteDataSource: myInjection(),
      loginLocalDataSource: myInjection(),
    ),
  );
  //DataSources
  myInjection.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(connectApi: myInjection()),
  );
  myInjection.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(secureStorage: myInjection()),
  );

  //Profil bloc
  myInjection.registerLazySingleton(
    () => ProfilBloc(
      getMahasiswa: myInjection(),
      patchMahasiswa: myInjection(),
      logOutUseCases: myInjection(),
    ),
  );
  //usecases
  myInjection.registerLazySingleton(
    () => GetMahasiswa(profilRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => PatchMahasiswa(profilRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => LogOutUseCases(loginRepositories: myInjection()),
  );
  //repository
  myInjection.registerLazySingleton<ProfilRepository>(
    () => ProfilRepositoryImplementation(
      profilLocalDataSource: myInjection(),
      profilRemoteDataSourceImplementation: myInjection(),
      agamaRemoteDataSource: myInjection(),
      programStudiRemoteDataSource: myInjection(),
      statusRemoteDataSource: myInjection(),
      waktuKuliahRemoteDataSource: myInjection(),
    ),
  );
  //datasource
  myInjection.registerLazySingleton<ProfilRemoteDatasource>(
    () => ProfilRemoteDataSourceImplementation(connectApi: myInjection()),
  );
  myInjection.registerLazySingleton<ProfilLocalDataSource>(
    () => ProfilLocalDataSourceImplementation(myInjection()),
  );

  //Program Studi
  //UseCases
  myInjection.registerLazySingleton(
    () => GetProgramStudi(programStudiRepositories: myInjection()),
  );
  //Repositories
  myInjection.registerLazySingleton<ProgramStudiRepositories>(
    () => ProgramStudiRepositoriesImplementation(
      programStudiRemoteDataSource: myInjection(),
      localProgramStudiDataSource: myInjection(),
    ),
  );
  //DataSources
  myInjection.registerLazySingleton<ProgramStudiRemoteDataSource>(
    () => ProgramStudiRemoteDataSourceImplementation(connectApi: myInjection()),
  );
  myInjection.registerLazySingleton<LocalProgramStudiDataSource>(
    () => LocalProgramStudiDataSourceImplementation(myInjection()),
  );

  //Agama
  myInjection.registerFactory(() => AgamaBloc(getAgama: myInjection()));
  //UseCases
  myInjection.registerLazySingleton(
    () => GetAgama(agamaRepositories: myInjection()),
  );
  //Repositories
  myInjection.registerLazySingleton<AgamaRepositories>(
    () => AgamaRepositoriesImplementation(
      agamaRemoteDataSource: myInjection(),
      agamaLocalDataSource: myInjection(),
    ),
  );
  //DataSources
  myInjection.registerLazySingleton<AgamaRemoteDataSource>(
    () => AgamaRemoteDataSourceImplementation(connectApi: myInjection()),
  );
  myInjection.registerLazySingleton<AgamaLocalDataSource>(
    () => AgamaLocalDataSourceImplementation(myInjection()),
  );

  //Status
  myInjection.registerFactory(() => StatusBloc(getStatus: myInjection()));
  //UseCases
  myInjection.registerLazySingleton(
    () => GetStatus(statusRepositories: myInjection()),
  );
  //Repositories
  myInjection.registerLazySingleton<StatusRepositories>(
    () => StatusRepositoriesImplementation(
      statusLocalDataSource: myInjection(),
      statusRemoteDataSource: myInjection(),
    ),
  );
  //DataSources
  myInjection.registerLazySingleton<StatusRemoteDataSource>(
    () => StatusRemoteDataSourceImpl(connectApi: myInjection()),
  );
  myInjection.registerLazySingleton<StatusLocalDataSource>(
    () => StatusLocalDataSourceImpl(secureStorage: myInjection()),
  );

  //Waktu Kuliah
  myInjection.registerFactory(
    () => WaktuKuliahBloc(getWaktuKuliah: myInjection()),
  );
  //UseCases
  myInjection.registerLazySingleton(() => GetWaktuKuliah(myInjection()));
  //Repositories
  myInjection.registerLazySingleton<WaktuKuliahRepositories>(
    () => WaktuKuliahRepositoriesImplementation(
      localDataSource: myInjection(),
      remoteDataSource: myInjection(),
    ),
  );
  //DataSources
  myInjection.registerLazySingleton<WaktuKuliahRemoteDataSource>(
    () => WaktuKuliahRemoteDataSourceImplementation(connectApi: myInjection()),
  );
  myInjection.registerLazySingleton<WaktuKuliahLocalDataSource>(
    () =>
        WaktuKuliahLocalDataSourceImplementation(secureStorage: myInjection()),
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
    () => TranskripBloc(
      getTranskrip: myInjection(),
      profilLocalDataSource: myInjection(),
    ),
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
    () => KrsBloc(getKrs: myInjection(), profilLocalDataSource: myInjection(), loginLocalDataSource: myInjection()),
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
    () => KhsBloc(getKhs: myInjection(), profilLocalDataSource: myInjection()),
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
