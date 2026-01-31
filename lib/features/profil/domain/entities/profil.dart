import 'package:equatable/equatable.dart';

class Profil extends Equatable {
  final int idPendaftaran;
  final int idUser;
  final String? idAgama;
  final String? kodeKampus;
  final String? kodeProgramStudi;
  final String? namaSekolah;
  final int? idStatus;
  final int? idWaktuKuliah;
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
    required this.idPendaftaran,
    required this.idUser,
    this.idAgama,
    this.kodeKampus,
    this.kodeProgramStudi,
    this.namaSekolah,
    this.idStatus,
    this.idWaktuKuliah,
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
    idUser,
    idAgama,
    kodeKampus,
    kodeProgramStudi,
    namaSekolah,
    idStatus,
    idWaktuKuliah,
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
