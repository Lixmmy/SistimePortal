import 'package:sistime_portal/core/localization/l10n/app_localizations.dart';

AppLocalizations? _appLocalizations;

AppLocalizations get appL10n {
  assert(
    _appLocalizations != null,
    'AppLocalizationService belum diinisialisasi. Panggil setLocalization() terlebih dahulu.',
  );
  return _appLocalizations!;
}

void setLocalization(AppLocalizations l10n) {
  _appLocalizations = l10n;
}
