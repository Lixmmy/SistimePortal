import 'package:newsistime/features/profil/domain/entities/profil.dart';

class ProfilModel {
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
  final int? tanggalIjazah;
  final int? tanggalPendaftaran;
  final String? noIjazah;
  final String? noTeleponMahasiswa;
  final String? noTeleponOrangtua;
  final int? tahunAngkatan;
  final String? pekerjaanOrangtua;
  final String? pendidikanOrangtua;
  final int? tahunLulus;
  const ProfilModel({
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
    this.tanggalIjazah,
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

  factory ProfilModel.fromjson(Map<String, dynamic> datajson) {
    return ProfilModel(
      idUser: datajson['idUser'],
      idAgama: datajson['idAgama'],
      idPendaftaran: datajson['idPendaftaran'],
      kodeKampus: datajson['kodeKampus'],
      kodeProgramStudi: datajson['kodeProgramStudi'],
      namaSekolah: datajson['namaSekolah'],
      idStatus: datajson['idStatus'],
      idWaktuKuliah: datajson['idWaktuKuliah'],
      email: datajson['email'],
      namaMahasiswa: datajson['namaMahasiswa'],
      tempatLahir: datajson['tempatLahir'],
      tanggalLahir: datajson['tanggalLahir'],
      tanggalPendaftaran: datajson['tanggalPendaftaran'],
      tanggalIjazah: datajson['tanggalIjazah'],
      alamatMahasiswa: datajson['alamatMahasiswa'],
      jenisKelamin: datajson['jenisKelamin'],
      alamatOrangtua: datajson['alamatOrangtua'],
      anakKe: datajson['anakKe'],
      golonganDarah: datajson['golonganDarah'],
      hobi: datajson['hobi'],
      jumlahSaudara: datajson['jumlahSaudara'],
      jurusanSekolah: datajson['jurusanSekolah'],
      kewarganegaraan: datajson['kewarganegaraan'],
      keterangan: datajson['keterangan'],
      namaAyah: datajson['namaAyah'],
      namaIbu: datajson['namaIbu'],
      noIjazah: datajson['noIjazah'],
      noTeleponMahasiswa: datajson['noTeleponMahasiswa'],
      noTeleponOrangtua: datajson['noTeleponOrangtua'],
      tahunAngkatan: datajson['tahunAngkatan'],
      pekerjaanOrangtua: datajson['pekerjaanOrangtua'],
      pendidikanOrangtua: datajson['pendidikanOrangtua'],
      tahunLulus: datajson['tahunLulus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'idAgama': idAgama,
      'idPendaftaran': idPendaftaran,
      'kodeKampus': kodeKampus,
      'kodeProgramStudi': kodeProgramStudi,
      'namaSekolah': namaSekolah,
      'idStatus': idStatus,
      'idWaktuKuliah': idWaktuKuliah,
      'email': email,
      'namaMahasiswa': namaMahasiswa,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir,
      'tanggalPendaftaran': tanggalPendaftaran,
      'tanggalIjazah': tanggalIjazah,
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
      'tahunLulus': tahunLulus,
    };
  }

  Profil toEntity() {
    return Profil(
      idPendaftaran: idPendaftaran,
      idUser: idUser,
      idAgama: idAgama,
      kodeKampus: kodeKampus,
      kodeProgramStudi: kodeProgramStudi,
      namaSekolah: namaSekolah,
      idStatus: idStatus,
      idWaktuKuliah: idWaktuKuliah,
      email: email,
      namaMahasiswa: namaMahasiswa,
      tempatLahir: tempatLahir,
      tanggalLahir: tanggalLahir,
      alamatMahasiswa: alamatMahasiswa,
      jenisKelamin: jenisKelamin,
      alamatOrangtua: alamatOrangtua,
      anakKe: anakKe,
      golonganDarah: golonganDarah,
      hobi: hobi,
      jumlahSaudara: jumlahSaudara,
      jurusanSekolah: jurusanSekolah,
      kewarganegaraan: kewarganegaraan,
      keterangan: keterangan,
      namaAyah: namaAyah,
      namaIbu: namaIbu,
      tanggalIjazah: tanggalIjazah,
      tanggalPendaftaran: tanggalPendaftaran,
      noIjazah: noIjazah,
      noTeleponMahasiswa: noTeleponMahasiswa,
      noTeleponOrangtua: noTeleponOrangtua,
      tahunAngkatan: tahunAngkatan,
      pekerjaanOrangtua: pekerjaanOrangtua,
      pendidikanOrangtua: pendidikanOrangtua,
      tahunLulus: tahunLulus,
    );
  }
}
