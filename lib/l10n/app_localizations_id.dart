// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String welcomeMessage(Object userName) {
    return 'Selamat datang, $userName!';
  }

  @override
  String get profile => 'Profil';

  @override
  String get infoProfil => 'Info Profil';

  @override
  String get language => 'Bahasa';

  @override
  String get studentIdCard => 'Kartu Tanda Mahasiswa';

  @override
  String get changePassword => 'Ganti Kata Sandi';

  @override
  String get logout => 'Keluar';

  @override
  String get profileDataNotAvailable => 'Data profil tidak tersedia';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get languageSettings => 'Pengaturan Bahasa';

  @override
  String languageChangedConfirmation(Object languageName) {
    return 'Bahasa berhasil diubah ke $languageName';
  }

  @override
  String get email => 'Email';

  @override
  String get major => 'Jurusan';

  @override
  String get yearOfEntry => 'Angkatan';

  @override
  String get religion => 'Agama';

  @override
  String get noHp => 'No.Hp';

  @override
  String get editProfile => 'Edit Profil';

  @override
  String get studentIdNumber => 'No. Induk Mahasiswa';

  @override
  String get studentCard => 'Kartu Tanda Mahasiswa';

  @override
  String get identityCard => 'Kartu Indentitas';

  @override
  String get placeAndDateOfBirth => 'Tempat/Tgl Lahir';

  @override
  String get name => 'Nama';

  @override
  String get studyPrograms => 'Program Studi';

  @override
  String get validUntil => 'Berlaku Sampai';

  @override
  String get editPhoto => 'Edit Foto';

  @override
  String get placeOfBirth => 'Tempat Lahir';

  @override
  String get dateOfBirth => 'Tanggal Lahir';

  @override
  String get nim => 'Nim';

  @override
  String get roomClass => 'Kelas';

  @override
  String get summary => 'Ringkasan';

  @override
  String get numberOfCoursesPassed => 'Jumlah Mata Kuliah Lulus';

  @override
  String get numberOfCoursesNotPassed => 'Jumlah Mata Kuliah Tidak Lulus';

  @override
  String get numberofCredits => 'Jumlah SKS';

  @override
  String get temporaryGPA => 'IPK Sementara';

  @override
  String get gpa => 'IPK';

  @override
  String get finalGPA => 'IPK Akhir';

  @override
  String get semester => 'Semester';

  @override
  String get studyPlanCard => 'Kartu Rencana Studi';

  @override
  String get studyResultsCard => 'Kartu Hasil Studi';

  @override
  String get valueTranscript => 'Nilai Transkrip';
}
