import 'package:equatable/equatable.dart';
import 'package:newsistime/features/profil/domain/entities/biodata_kampus.dart';

//buat class programstudi
//buat class agama
//buat class kampus


class Profil extends Equatable {
  final int idPendaftaran;
  final User user;
  final Agama agama;
  final Kampus kampus;
  final ProgramStudi programStudi;
  final Sekolah sekolah;
  final Status status;
  final WaktuKuliah waktuKuliah;
  final String email;
  final String namaMahasiswa;
  final String? tempatLahir;
  final int? tanggalLahir;
  final String? alamatMahasiswa;
  final String? jenisKelamin;
  final String? alamatOrangtua;
  final int? anakKe;
  final String? golonganDarah;
  final String? hobi;
  final int? jumlahSaudara;
  final String? jurusanSekolah;
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
    required this.user,
    required this.agama,
    required this.idPendaftaran,
    required this.kampus,
    required this.programStudi,
    required this.sekolah,
    required this.status,
    required this.waktuKuliah,
    required this.email,
    required this.namaMahasiswa,
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
    this.jurusanSekolah,
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
    user,
    agama,
    kampus,
    programStudi,
    sekolah,
    status,
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
    jurusanSekolah,
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
