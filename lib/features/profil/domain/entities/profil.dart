import 'package:equatable/equatable.dart';

class Profil extends Equatable {
  final int idPendaftaran;
  final Map<String, dynamic>user;
  final Map<String, dynamic> agama;
  final Map<String, dynamic> kampus;
  final Map<String, dynamic> programStudi;
  final Map<String, dynamic> sekolah;
  final Map<String, dynamic> status;
  final Map<String, dynamic> waktuKuliah;
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
  final int? noIjazah;
  final String? noTeleponMahasiswa;
  final String? noTeleponOrangtua;
  final int? tahunAngkatan;
  final String? pekerjaanOrangtua;
  final String? pendidikanOrangtua;
  final int? tahunLulus;
  const Profil(
    {
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
