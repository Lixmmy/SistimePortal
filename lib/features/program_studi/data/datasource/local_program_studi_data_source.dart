import 'dart:convert';

import 'package:sistime_portal/core/helper/secure_storage.dart';
import 'package:sistime_portal/features/program_studi/data/models/program_studi_models.dart';

abstract class LocalProgramStudiDataSource {
  Future<List<ProgramStudiModel>> getSavedProgramStudi();
  Future<void> savedProgramStudi(List<ProgramStudiModel> programStudi);
}

class LocalProgramStudiDataSourceImplementation
    extends LocalProgramStudiDataSource {
  final SecureStorage _secureStorage;
  static const String _programStudiKey = 'program_studi_data';
  LocalProgramStudiDataSourceImplementation(this._secureStorage);
  @override
  Future<List<ProgramStudiModel>> getSavedProgramStudi() async {
    try {
      final jsonString = await _secureStorage.getData(_programStudiKey);
      if (jsonString.isEmpty) {
        return [];
      }
      final programStudiJson = jsonDecode(jsonString) as List;
      return programStudiJson
          .map((e) => ProgramStudiModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> savedProgramStudi(List<ProgramStudiModel> programStudi) async {
    try {
      final programStudiJson = programStudi.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(programStudiJson);
      await _secureStorage.saveData(_programStudiKey, jsonString);
    } catch (e) {
      rethrow;
    }
  }
}
