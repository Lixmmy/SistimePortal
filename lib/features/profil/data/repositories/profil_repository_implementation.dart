import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/agama/data/datasources/agama_remote_data_source.dart';
import 'package:newsistime/features/profil/data/models/profil_model.dart';
import 'package:newsistime/features/program_studi/data/datasource/program_studi_remote_data_source.dart';
import 'package:newsistime/features/status/data/datasource/status_remote_data_source.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../../domain/entities/profil.dart';
import '../../domain/repositories/profil_repository.dart';

class ProfilRepositoryImplementation extends ProfilRepository {
  final ProfilRemoteDatasource profilRemoteDataSourceImplementation;
  final AgamaRemoteDataSource agamaRemoteDataSource;
  final ProgramStudiRemoteDataSource programStudiRemoteDataSource;
  final ProfilLocalDataSource profilLocalDataSource;
  final StatusRemoteDataSource statusRemoteDataSource;

  ProfilRepositoryImplementation({
    required this.profilLocalDataSource,
    required this.profilRemoteDataSourceImplementation,
    required this.agamaRemoteDataSource,
    required this.programStudiRemoteDataSource,
    required this.statusRemoteDataSource,
  });

  @override
  Future<Either<MessageExc, Profil>> getMahasiswa(String nim) async {
    try {
      final ProfilModel hasil = await profilRemoteDataSourceImplementation
          .getMahasiswa(nim);
      final agamas = await agamaRemoteDataSource.getAgama();
      final agama = agamas.firstWhere((e) => e.id == hasil.idAgama);
      final programStudis = await programStudiRemoteDataSource
          .getProgramStudi();
      final programStudi = programStudis.firstWhere(
        (e) => e.kodeProgramstudi == hasil.kodeProgramStudi,
      );
      final statusList = await statusRemoteDataSource.getStatus();
      final status = statusList.firstWhere((e) => e.idStatus == hasil.idStatus);
      final correctProfil = ProfilModel(
        idPendaftaran: hasil.idPendaftaran,
        idUser: hasil.idUser,
        idAgama: hasil.idAgama,
        agama: agama,
        kodeKampus: hasil.kodeKampus,
        kodeProgramStudi: hasil.kodeProgramStudi,
        programStudi: programStudi,
        namaSekolah: hasil.namaSekolah,
        idStatus: hasil.idStatus,
        status: status,
        idWaktuKuliah: hasil.idWaktuKuliah,
        email: hasil.email,
        namaMahasiswa: hasil.namaMahasiswa,
        tempatLahir: hasil.tempatLahir,
        tanggalLahir: hasil.tanggalLahir,
        alamatMahasiswa: hasil.alamatMahasiswa,
        jenisKelamin: hasil.jenisKelamin,
        alamatOrangtua: hasil.alamatOrangtua,
        anakKe: hasil.anakKe,
        golonganDarah: hasil.golonganDarah,
        hobi: hasil.hobi,
        jumlahSaudara: hasil.jumlahSaudara,
        jurusanSekolah: hasil.jurusanSekolah,
        kewarganegaraan: hasil.kewarganegaraan,
        keterangan: hasil.keterangan,
        namaAyah: hasil.namaAyah,
        namaIbu: hasil.namaIbu,
        noIjazah: hasil.noIjazah,
        noTeleponMahasiswa: hasil.noTeleponMahasiswa,
        noTeleponOrangtua: hasil.noTeleponOrangtua,
        tahunAngkatan: hasil.tahunAngkatan,
        pekerjaanOrangtua: hasil.pekerjaanOrangtua,
        pendidikanOrangtua: hasil.pendidikanOrangtua,
        tanggalIjazah: hasil.tanggalIjazah,
        tanggalPendaftaran: hasil.tanggalPendaftaran,
        tahunLulus: hasil.tahunLulus,
      );
      profilLocalDataSource.savedProfilData(correctProfil);
      return Right(correctProfil.toEntity());
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
