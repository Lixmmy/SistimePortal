import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @welcomeMessage.
  ///
  /// In id, this message translates to:
  /// **'Selamat datang, {userName}!'**
  String welcomeMessage(Object userName);

  /// No description provided for @profile.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profile;

  /// No description provided for @infoProfil.
  ///
  /// In id, this message translates to:
  /// **'Info Profil'**
  String get infoProfil;

  /// No description provided for @language.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get language;

  /// No description provided for @studentIdCard.
  ///
  /// In id, this message translates to:
  /// **'Kartu Tanda Mahasiswa'**
  String get studentIdCard;

  /// No description provided for @changePassword.
  ///
  /// In id, this message translates to:
  /// **'Ganti Kata Sandi'**
  String get changePassword;

  /// No description provided for @logout.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logout;

  /// No description provided for @profileDataNotAvailable.
  ///
  /// In id, this message translates to:
  /// **'Data profil tidak tersedia'**
  String get profileDataNotAvailable;

  /// No description provided for @selectLanguage.
  ///
  /// In id, this message translates to:
  /// **'Pilih Bahasa'**
  String get selectLanguage;

  /// No description provided for @languageSettings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan Bahasa'**
  String get languageSettings;

  /// No description provided for @languageChangedConfirmation.
  ///
  /// In id, this message translates to:
  /// **'Bahasa berhasil diubah ke {languageName}'**
  String languageChangedConfirmation(Object languageName);

  /// No description provided for @email.
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @major.
  ///
  /// In id, this message translates to:
  /// **'Jurusan'**
  String get major;

  /// No description provided for @yearOfEntry.
  ///
  /// In id, this message translates to:
  /// **'Angkatan'**
  String get yearOfEntry;

  /// No description provided for @religion.
  ///
  /// In id, this message translates to:
  /// **'Agama'**
  String get religion;

  /// No description provided for @noHp.
  ///
  /// In id, this message translates to:
  /// **'No.Hp'**
  String get noHp;

  /// No description provided for @editProfile.
  ///
  /// In id, this message translates to:
  /// **'Edit Profil'**
  String get editProfile;

  /// No description provided for @studentIdNumber.
  ///
  /// In id, this message translates to:
  /// **'No. Induk Mahasiswa'**
  String get studentIdNumber;

  /// No description provided for @studentCard.
  ///
  /// In id, this message translates to:
  /// **'Kartu Tanda Mahasiswa'**
  String get studentCard;

  /// No description provided for @identityCard.
  ///
  /// In id, this message translates to:
  /// **'Kartu Indentitas'**
  String get identityCard;

  /// No description provided for @placeAndDateOfBirth.
  ///
  /// In id, this message translates to:
  /// **'Tempat/Tgl Lahir'**
  String get placeAndDateOfBirth;

  /// No description provided for @name.
  ///
  /// In id, this message translates to:
  /// **'Nama'**
  String get name;

  /// No description provided for @studyPrograms.
  ///
  /// In id, this message translates to:
  /// **'Program Studi'**
  String get studyPrograms;

  /// No description provided for @validUntil.
  ///
  /// In id, this message translates to:
  /// **'Berlaku Sampai'**
  String get validUntil;

  /// No description provided for @editPhoto.
  ///
  /// In id, this message translates to:
  /// **'Edit Foto'**
  String get editPhoto;

  /// No description provided for @placeOfBirth.
  ///
  /// In id, this message translates to:
  /// **'Tempat Lahir'**
  String get placeOfBirth;

  /// No description provided for @dateOfBirth.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Lahir'**
  String get dateOfBirth;

  /// No description provided for @nim.
  ///
  /// In id, this message translates to:
  /// **'Nim'**
  String get nim;

  /// No description provided for @roomClass.
  ///
  /// In id, this message translates to:
  /// **'Kelas'**
  String get roomClass;

  /// No description provided for @summary.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan'**
  String get summary;

  /// No description provided for @numberOfCoursesPassed.
  ///
  /// In id, this message translates to:
  /// **'Jumlah Mata Kuliah Lulus'**
  String get numberOfCoursesPassed;

  /// No description provided for @numberOfCoursesNotPassed.
  ///
  /// In id, this message translates to:
  /// **'Jumlah Mata Kuliah Tidak Lulus'**
  String get numberOfCoursesNotPassed;

  /// No description provided for @numberofCredits.
  ///
  /// In id, this message translates to:
  /// **'Jumlah SKS'**
  String get numberofCredits;

  /// No description provided for @temporaryGPA.
  ///
  /// In id, this message translates to:
  /// **'IPK Sementara'**
  String get temporaryGPA;

  /// No description provided for @gpa.
  ///
  /// In id, this message translates to:
  /// **'IPK'**
  String get gpa;

  /// No description provided for @finalGPA.
  ///
  /// In id, this message translates to:
  /// **'IPK Akhir'**
  String get finalGPA;

  /// No description provided for @semester.
  ///
  /// In id, this message translates to:
  /// **'Semester'**
  String get semester;

  /// No description provided for @studyPlanCard.
  ///
  /// In id, this message translates to:
  /// **'Kartu Rencana Studi'**
  String get studyPlanCard;

  /// No description provided for @studyResultsCard.
  ///
  /// In id, this message translates to:
  /// **'Kartu Hasil Studi'**
  String get studyResultsCard;

  /// No description provided for @valueTranscript.
  ///
  /// In id, this message translates to:
  /// **'Nilai Transkrip'**
  String get valueTranscript;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
