// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get helloWorld => 'Halo Dunia!';

  @override
  String welcomeMessage(Object userName) {
    return 'Selamat datang, $userName!';
  }

  @override
  String itemCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count item',
      one: '1 item',
      zero: 'Tidak ada item',
    );
    return '$_temp0';
  }

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
}
