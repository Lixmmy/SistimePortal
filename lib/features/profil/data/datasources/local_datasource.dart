import 'dart:convert';

import 'package:sistime_portal/features/profil/data/models/profil_model.dart';
import '../../../../core/helper/secure_storage.dart';

abstract class ProfilLocalDataSource {
  Future<ProfilModel?> getSavedProfilData();
  Future<void> savedProfilData(ProfilModel profil);
}

class ProfilLocalDataSourceImplementation extends ProfilLocalDataSource {
  final SecureStorage _secureStorage;
  static const String _profilKey = 'profil_data';
  ProfilLocalDataSourceImplementation(this._secureStorage);

  @override
  Future<void> savedProfilData(ProfilModel profil) async {
    try {
      final profilJson = profil.toLocalJson();
      final jsonString = jsonEncode(profilJson);
      await _secureStorage.saveData(_profilKey, jsonString);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfilModel?> getSavedProfilData() async {
    try {
      final jsonString = await _secureStorage.getData(_profilKey);
      if (jsonString.isEmpty) {
        return null;
      }
      final profilJson = jsonDecode(jsonString) as Map<String, dynamic>;
      return ProfilModel.fromLocalJson(profilJson);
    } catch (e) {
      return null;
    }
  }
}
