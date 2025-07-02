// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String welcomeMessage(Object userName) {
    return 'Welcome, $userName!';
  }

  @override
  String itemCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get infoProfil => 'Profile Info';

  @override
  String get language => 'Language';

  @override
  String get studentIdCard => 'Student ID Card';

  @override
  String get changePassword => 'Change Password';

  @override
  String get logout => 'Logout';

  @override
  String get profileDataNotAvailable => 'Profile data not available';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String languageChangedConfirmation(Object languageName) {
    return 'Language changed to $languageName';
  }
}
