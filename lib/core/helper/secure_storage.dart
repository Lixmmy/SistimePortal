import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{

static WebOptions _webOptions() => WebOptions(dbName: 'Sistime5tmik', publicKey: 'SqlSt1m1k7im3');
  static AndroidOptions _androidOptions() => AndroidOptions(encryptedSharedPreferences: true);
  static IOSOptions _iosOptions() => IOSOptions(synchronizable: true);

  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: _androidOptions(),
    iOptions: _iosOptions(),
    webOptions: _webOptions(),
  );

  Future<void> savaData(String key, dynamic value) async{
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      if (kIsWeb) {
        debugPrint('SecureStorage: Failed to save data on web: $e');
      } else {
        rethrow;
      }
    }
  }
  Future<String> getData(String key) async {
    try {
      final value = await _secureStorage.read(key: key);
      return value ?? '';
    } catch (e) {
      if (kIsWeb) {
        debugPrint('SecureStorage: Failed to read data on web: $e');
        return '';
      } else {
        rethrow;
      }
    }
  }

  Future<void> deleteData(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      if (kIsWeb) {
        debugPrint('SecureStorage: Failed to delete data on web: $e');
      } else {
        rethrow;
      }
    }
  }

  Future<void> deleteAllData() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      if (kIsWeb) {
        debugPrint('SecureStorage: Failed to delete all data on web: $e');
      } else {
        rethrow;
      }
    }
  }
}