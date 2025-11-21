import 'package:newsistime/features/profil/data/models/biodata_kampus_model.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';

class ProfilModel {
  final int idPendaftaran;
  final UserModel user;
  final AgamaModel? agama;
  final KampusModel? kampus;
  final ProgramStudiModel? programStudi;
  final SekolahModel? sekolah;
  final StatusModel? status;
  final WaktuKuliahModel? waktuKuliah;
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
    required this.user,
    this.agama,
    this.kampus,
    this.programStudi,
    required this.sekolah,
    required this.status,
    required this.waktuKuliah,
    required this.email,
    required this.namaMahasiswa,
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
      user: UserModel.fromJson(datajson['user']),
      agama: datajson['agama'] == null
          ? null
          : AgamaModel.fromJson(datajson['agama']),
      idPendaftaran: datajson['idPendaftaran'],
      kampus: datajson['kampus'] == null
          ? null
          : KampusModel.fromJson(datajson['kampus']),
      programStudi: datajson['programStudi'] == null
          ? null
          : ProgramStudiModel.fromJson(datajson['programStudi']),
      sekolah: datajson['sekolah'] == null
          ? null
          : SekolahModel.fromJson(datajson['sekolah']),
      status: datajson['status'] == null
          ? null
          : StatusModel.fromJson(datajson['status']),
      waktuKuliah: datajson['waktuKuliah'] == null
          ? null
          : WaktuKuliahModel.fromJson(datajson['waktuKuliah']),
      email: datajson['email'],
      namaMahasiswa: datajson['namaMahasiswa'],
      tempatLahir: datajson['tempatLahir'],
      tanggalLahir: datajson['tanggalLahir'],
      alamatMahasiswa: datajson['alamatMahasiswa'],
      jenisKelamin: datajson['jenisKelamin'] ?? '',
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
      tanggalIjazah: datajson['tanggalIjazah'],
      tanggalPendaftaran: datajson['tanggalPendaftaran'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'agama': agama!.toJson(),
      'idPendaftaran': idPendaftaran,
      'kampus': kampus!.toJson(),
      'programStudi': programStudi!.toJson(),
      'sekolah': sekolah!.toJson(),
      'status': status!.toJson(),
      'waktuKuliah': waktuKuliah!.toJson(),
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
      'tahunLulus': tahunLulus,
      'tanggalIjazah': tanggalIjazah,
      'tanggalPendaftaran': tanggalPendaftaran,
    };
  }

  Profil toEntity() {
    return Profil(
      idPendaftaran: idPendaftaran,
      user: user.toEntity(),
      agama: agama?.toEntity(),
      kampus: kampus?.toEntity(),
      programStudi: programStudi?.toEntity(),
      sekolah: sekolah?.toEntity(),
      status: status?.toEntity(),
      waktuKuliah: waktuKuliah?.toEntity(),
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
