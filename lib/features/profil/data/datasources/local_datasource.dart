import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/features/profil/data/models/profil_model.dart';
import 'package:http/http.dart' as http;
import 'package:newsistime/features/profil/domain/entities/profil.dart';

abstract class ProflLocalDatasource {
  Future<ProfilModel?> getSavedProfilData();
  Future<void> savedProfilData(ProfilModel profil);
}

class ProfilLocalDataSourceImplementation extends ProflLocalDatasource {
  final SecureStorage _secureStorage = SecureStorage();
  static const String _profilKey = 'profil_data';

  @override
  Future<void> savedProfilData(ProfilModel profil) async {
    try {
      final profilJson = profil.toJson();
      final jsonString = jsonEncode(profilJson);
      await _secureStorage.savaData(_profilKey, jsonString);
      debugPrint('SecureStorage: Profil data saved successfully!');
    } catch (e) {
      debugPrint('SecureStorage: Failed to save profil data: $e');
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
      return ProfilModel.fromjson(profilJson); // Perhatikan penggunaan `fromjson`
    } catch (e) {
      debugPrint('SecureStorage: Failed to read profil data: $e');
      return null;
    }
  }
}
