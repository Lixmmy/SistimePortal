import 'package:equatable/equatable.dart';
import 'package:newsistime/features/profil/domain/entities/biodata_kampus.dart';

//buat class programstudi
//buat class agama
//buat class kampus

class Profil extends Equatable {
  final int idPendaftaran;
  final User user;
  final Agama? agama;
  final Kampus? kampus;
  final ProgramStudi? programStudi;
  final Sekolah? sekolah;
  final Status? status;
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
    required this.user,
    this.agama,
    this.kampus,
    this.programStudi,
    this.sekolah,
    this.status,
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
  Map<String, dynamic> toJson() {
    return {
      'idPendaftaran': idPendaftaran,
      'user': user.toJson(),
      'agama': agama?.toJson(),
      'kampus': kampus?.toJson(),
      'programStudi': programStudi?.toJson(),
      'sekolah': sekolah?.toJson(),
      'status': status?.toJson(),
      'waktuKuliah': waktuKuliah?.toJson(),
      'email': email,
      'namaMahasiswa': namaMahasiswa,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir,
      'alamatMahasiswa': alamatMahasiswa,
      'jenisKelamin': jenisKelamin,
      'alamatOrangtua': alamatOrangtua,
      'anakKe': anakKe,
      'golonganDarah': golonganDarah,
      'hobi': hobi,
      'jumlahSaudara': jumlahSaudara,
      'jurusanSekolah': jurusanSekolah,
      'kewarganegaraan': kewarganegaraan,
      'keterangan': keterangan,
      'namaAyah': namaAyah,
      'namaIbu': namaIbu,
      'noIjazah': noIjazah,
      'noTeleponMahasiswa': noTeleponMahasiswa,
      'noTeleponOrangtua': noTeleponOrangtua,
      'tahunAngkatan': tahunAngkatan,
      'pekerjaanOrangtua': pekerjaanOrangtua,
      'pendidikanOrangtua': pendidikanOrangtua,
      'tanggalIjazah': tanggalIjazah,
      'tahunLulus': tahunLulus,
    };
  }

  factory Profil.fromjson(Map<String, dynamic> json) {
    return Profil(
      idPendaftaran: json['idPendaftaran'],
      user: User.fromJson(json['user']),
      agama: json['agama'] != null ? Agama.fromJson(json['agama']) : null,
      kampus: json['kampus'] != null ? Kampus.fromJson(json['kampus']) : null,
      programStudi: json['programStudi'] != null
          ? ProgramStudi.fromJson(json['programStudi'])
          : null,
      sekolah:
          json['sekolah'] != null ? Sekolah.fromJson(json['sekolah']) : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      waktuKuliah: json['waktuKuliah'] != null
          ? WaktuKuliah.fromJson(json['waktuKuliah'])
          : null,
      email: json['email'],
      namaMahasiswa: json['namaMahasiswa'],
      tempatLahir: json['tempatLahir'],
      tanggalLahir: json['tanggalLahir'],
      alamatMahasiswa: json['alamatMahasiswa'],
      jenisKelamin: json['jenisKelamin'],
      alamatOrangtua: json['alamatOrangtua'],
      anakKe: json['anakKe'],
      golonganDarah: json['golonganDarah'],
      hobi: json['hobi'],
      jumlahSaudara: json['jumlahSaudara'],
      jurusanSekolah: json['jurusanSekolah'],
      kewarganegaraan: json['kewarganegaraan'],
      keterangan: json['keterangan'],
      namaAyah: json['namaAyah'],
      namaIbu: json['namaIbu'],
      noIjazah: json['noIjazah'],
      noTeleponMahasiswa: json['noTeleponMahasiswa'],
      noTeleponOrangtua: json['noTeleponOrangtua'],
      tahunAngkatan: json['tahunAngkatan'],
      pekerjaanOrangtua: json['pekerjaanOrangtua'],
      pendidikanOrangtua: json['pendidikanOrangtua'],
      tanggalIjazah: json['tanggalIjazah'],
      tahunLulus: json['tahunLulus'],
      tanggalPendaftaran: json['tanggalPendaftaran'],
    );
  }
}
