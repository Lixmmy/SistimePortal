import 'package:newsistime/core/helper/secure_storage.dart';

abstract class LanguageLocalDataSource {
  Future<void> saveLanguage(String langCode);
  Future<String?> getSavedLanguage();
}

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  final SecureStorage secureStorage;

  LanguageLocalDataSourceImpl(this.secureStorage);

  static const String _cachedLanguageKey = 'CACHED_LANGUAGE';

  @override
  Future<String?> getSavedLanguage() async {
    try {
      final String value = await secureStorage.getData(_cachedLanguageKey);
      return value.isEmpty ? null : value;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveLanguage(String langCode) async {
    try {
      await secureStorage.saveData(_cachedLanguageKey, langCode);
    } catch (e) {
      rethrow;
    }
  }
}
