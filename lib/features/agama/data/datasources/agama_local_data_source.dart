import 'dart:convert';

import 'package:sistime_portal/core/helper/secure_storage.dart';
import 'package:sistime_portal/features/agama/data/models/agama_model.dart';

abstract class AgamaLocalDataSource {
  Future<List<AgamaModel>> getSavedAgama();
  Future<void> savedAgama(List<AgamaModel> agama);
}

class AgamaLocalDataSourceImplementation implements AgamaLocalDataSource {
  final SecureStorage _secureStorage;
  static const String _agamaKey = 'agama_data';

  AgamaLocalDataSourceImplementation(this._secureStorage);

  @override
  Future<List<AgamaModel>> getSavedAgama() async {
    try {
      final jsonString = await _secureStorage.getData(_agamaKey);
      if (jsonString.isEmpty) {
        return [];
      }
      final agamaJson = jsonDecode(jsonString) as List;
      return agamaJson.map((e) => AgamaModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> savedAgama(List<AgamaModel> agama) async {
    try {
      final agamaJson = agama.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(agamaJson);
      _secureStorage.saveData(_agamaKey, jsonString);
    } catch (e) {
      rethrow;
    }
  }
}
