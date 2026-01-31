import 'dart:convert';

import 'package:newsistime/features/status/data/models/status_model.dart';
import 'package:newsistime/core/helper/secure_storage.dart';

abstract class StatusLocalDataSource {
  Future<List<StatusModel>> getSavedStatus();
  Future<void> savedStatus(List<StatusModel> status);
}

class StatusLocalDataSourceImpl implements StatusLocalDataSource {
  final SecureStorage secureStorage;
  static const String _statusKey = 'status_data';

  StatusLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<List<StatusModel>> getSavedStatus() async {
    try {
      final jsonString = await secureStorage.getData(_statusKey);
      if (jsonString.isEmpty) {
        return [];
      }
      final statusJson = jsonDecode(jsonString) as List;
      return statusJson.map((e) => StatusModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> savedStatus(List<StatusModel> status) async {
    try {
      final statusJson = status.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(statusJson);
      secureStorage.saveData(_statusKey, jsonString);
    } catch (e) {
      rethrow;
    }
  }
}
