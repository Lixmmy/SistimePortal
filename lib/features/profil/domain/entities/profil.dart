import 'package:equatable/equatable.dart';
import 'package:sistime_portal/features/agama/domain/entities/agama.dart';
import 'package:sistime_portal/features/program_studi/domain/entities/program_studi.dart';
import 'package:sistime_portal/features/status/domain/entities/status.dart';
import 'package:sistime_portal/features/status_mahasiswa/domain/entities/status_mahasiswa.dart';
import 'package:sistime_portal/features/waktu_kuliah/domain/entities/waktu_kuliah.dart';

class Profil extends Equatable {
  final int idPendaftaran;
  final int idUser;
  final String? idAgama;
  final Agama? agama;
  final String? kodeKampus;
  final String? kodeProgramStudi;
  final ProgramStudi? programStudi;
  final String? namaSekolah;
  final int? idStatus;
  final Status? status;
  final StatusMahasiswa? statusMahasiswa;
  final int? idWaktuKuliah;
  final WaktuKuliah? waktuKuliah;
  final String? email;
  final String? namaMahasiswa;
  final String? tempatLahir;
  final int? tanggalLahir;
  final String? alamatMahasiswa;
  final String? jenisKelamin;
  final String? alamatOrangtua;
  final int? anakKe;
  final String? golonganDarah;
  final String? hobi;
  final int? jumlahSaudara;
  final String? jurusan;
  final String? kewarganegaraan;
  final String? keterangan;
  final String? namaAyah;
  final String? namaIbu;
  final String? noIjazah;
  final String? noTeleponMahasiswa;
  final String? noTeleponOrangtua;
  final int? tahunAngkatan;
  final String? pekerjaanOrangtua;
  final String? pendidikanOrangtua;
  final int? tanggalIjazah;
  final int? tanggalPendaftaran;
  final int? tahunLulus;
  const Profil({
    required this.idPendaftaran,
    required this.idUser,
    this.statusMahasiswa,
    this.idAgama,
    this.agama,
    this.kodeKampus,
    this.kodeProgramStudi,
    this.programStudi,
    this.namaSekolah,
    this.idStatus,
    this.status,
    this.idWaktuKuliah,
    this.waktuKuliah,
    this.email,
    this.namaMahasiswa,
    this.tempatLahir,
    this.tanggalLahir,
    this.tanggalPendaftaran,
    this.alamatMahasiswa,
    this.jenisKelamin,
    this.alamatOrangtua,
    this.anakKe,
    this.golonganDarah,
    this.hobi,
    this.jumlahSaudara,
    this.jurusan,
    this.kewarganegaraan,
    this.keterangan,
    this.namaAyah,
    this.namaIbu,
    this.noIjazah,
    this.noTeleponMahasiswa,
    this.noTeleponOrangtua,
    this.tahunAngkatan,
    this.pekerjaanOrangtua,
    this.pendidikanOrangtua,
    this.tanggalIjazah,
    this.tahunLulus,
  });

  @override
  List<Object?> get props => [
    idPendaftaran,
    idUser,
    statusMahasiswa,
    idAgama,
    agama,
    kodeKampus,
    kodeProgramStudi,
    programStudi,
    namaSekolah,
    idStatus,
    status,
    idWaktuKuliah,
    waktuKuliah,
    email,
    namaMahasiswa,
    tempatLahir,
    tanggalLahir,
    alamatMahasiswa,
    jenisKelamin,
    alamatOrangtua,
    anakKe,
    golonganDarah,
    hobi,
    jumlahSaudara,
    jurusan,
    kewarganegaraan,
    keterangan,
    namaAyah,
    namaIbu,
    noIjazah,
    noTeleponMahasiswa,
    noTeleponOrangtua,
    tahunAngkatan,
    pekerjaanOrangtua,
    pendidikanOrangtua,
    tahunLulus,
  ];
}
