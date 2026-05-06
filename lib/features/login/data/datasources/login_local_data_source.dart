import 'package:newsistime/core/helper/secure_storage.dart';

abstract class LoginLocalDataSource {
  Future<void> saveToken(String token);
  Future<String> getToken();
  Future<void> deleteToken();
  Future<void> saveUsername(String username);
  Future<String> getUsername();
  Future<void> deleteUsername();
  Future<void> savePassword(String password);
  Future<String> getPassword();
  Future<void> deletePassword();
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SecureStorage secureStorage;

  LoginLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveToken(String token) {
    return secureStorage.saveData('token', token);
  }

  @override
  Future<String> getToken() {
    return secureStorage.getData('token');
  }

  @override
  Future<void> deleteToken() {
    return secureStorage.deleteData('token');
  }

  @override
  Future<void> saveUsername(String username) {
    return secureStorage.saveData('username', username);
  }

  @override
  Future<String> getUsername() {
    return secureStorage.getData('username');
  }

  @override
  Future<void> deleteUsername() {
    return secureStorage.deleteData('username');
  }

  @override
  Future<void> deletePassword() {
    return secureStorage.deleteData('password');
  }

  @override
  Future<void> savePassword(String password) {
    return secureStorage.saveData('password', password);
  }

  @override
  Future<String> getPassword() {
    return secureStorage.getData('password');
  }
}
