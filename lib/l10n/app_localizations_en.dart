// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String welcomeMessage(Object userName) {
    return 'Welcome, $userName!';
  }

  @override
  String get profile => 'Profile';

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

  @override
  String get email => 'Email';

  @override
  String get major => 'Major';

  @override
  String get yearOfEntry => 'Year of entry';

  @override
  String get religion => 'Religion';

  @override
  String get noHp => 'Phone Number';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get studentIdNumber => 'Student ID Number';

  @override
  String get studentCard => 'Student Card';

  @override
  String get identityCard => 'identity card';

  @override
  String get placeAndDateOfBirth => 'Place and Date of Birth';

  @override
  String get name => 'Name';

  @override
  String get studyPrograms => 'Study Programs';

  @override
  String get validUntil => 'Valid Until';

  @override
  String get editPhoto => 'Edit Photo';

  @override
  String get placeOfBirth => 'Place of Birth';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get nim => 'Nim';

  @override
  String get roomClass => 'Class';

  @override
  String get summary => 'Summary';

  @override
  String get numberOfCoursesPassed => 'Number of Courses Passed';

  @override
  String get numberOfCoursesNotPassed => 'Number of Courses Not Passed';

  @override
  String get numberofCredits => 'Number of Credits';

  @override
  String get temporaryGPA => 'Temporary GPA';

  @override
  String get gpa => 'GPA';

  @override
  String get finalGPA => 'Final GPA';

  @override
  String get semester => 'Semester';

  @override
  String get studyPlanCard => 'Study Plan Card';

  @override
  String get studyResultsCard => 'Study Results Card';

  @override
  String get valueTranscript => 'Value Transcripts';
}
