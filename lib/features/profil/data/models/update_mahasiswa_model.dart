class UpdateMahasiswaModel {
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
  final String? jurusan;
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

  const UpdateMahasiswaModel({
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
    this.tahunLulus,
    this.alamatMahasiswa,
    this.jenisKelamin,
    this.alamatOrangtua,
    this.anakKe,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> body = {};
    if (idAgama != null) body['idAgama'] = idAgama;
    if (kodeKampus != null) body['kodeKampus'] = kodeKampus;
    if (kodeProgramStudi != null) body['kodeProgramStudi'] = kodeProgramStudi;
    if (namaSekolah != null) body['namaSekolah'] = namaSekolah;
    if (idStatus != null) body['idStatus'] = idStatus;
    if (idWaktuKuliah != null) body['idWaktuKuliah'] = idWaktuKuliah;
    if (email != null) body['email'] = email;
    if (namaMahasiswa != null) body['namaMahasiswa'] = namaMahasiswa;
    if (tempatLahir != null) body['tempatLahir'] = tempatLahir;
    if (tanggalLahir != null) body['tanggalLahir'] = tanggalLahir;
    if (tanggalPendaftaran != null) {
      body['tanggalPendaftaran'] = tanggalPendaftaran;
    }
    if (tanggalIjazah != null) body['tanggalIjazah'] = tanggalIjazah;
    if (golonganDarah != null) body['golonganDarah'] = golonganDarah;
    if (hobi != null) body['hobi'] = hobi;
    if (jumlahSaudara != null) body['jumlahSaudara'] = jumlahSaudara;
    if (jurusan != null) body['jurusan'] = jurusan;
    if (kewarganegaraan != null) body['kewarganegaraan'] = kewarganegaraan;
    if (keterangan != null) body['keterangan'] = keterangan;
    if (namaAyah != null) body['namaAyah'] = namaAyah;
    if (namaIbu != null) body['namaIbu'] = namaIbu;
    if (noIjazah != null) body['noIjazah'] = noIjazah;
    if (noTeleponMahasiswa != null) {
      body['noTeleponMahasiswa'] = noTeleponMahasiswa;
    }
    if (noTeleponOrangtua != null) {
      body['noTeleponOrangtua'] = noTeleponOrangtua;
    }
    if (tahunAngkatan != null) body['tahunAngkatan'] = tahunAngkatan;
    if (pekerjaanOrangtua != null) {
      body['pekerjaanOrangtua'] = pekerjaanOrangtua;
    }
    if (pendidikanOrangtua != null) {
      body['pendidikanOrangtua'] = pendidikanOrangtua;
    }
    if (tahunLulus != null) body['tahunLulus'] = tahunLulus;
    if (alamatMahasiswa != null) body['alamatMahasiswa'] = alamatMahasiswa;
    if (jenisKelamin != null) body['jenisKelamin'] = jenisKelamin;
    if (alamatOrangtua != null) body['alamatOrangtua'] = alamatOrangtua;
    if (anakKe != null) body['anakKe'] = anakKe;
    return body;
  }
}
