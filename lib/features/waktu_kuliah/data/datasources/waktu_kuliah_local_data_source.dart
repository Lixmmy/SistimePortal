import 'dart:convert';

import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/features/waktu_kuliah/data/models/waktu_kuliah_model.dart';

abstract class WaktuKuliahLocalDataSource {
  Future<void> savedWaktuKuliah(List<WaktuKuliahModel> waktuKuliah);
  Future<List<WaktuKuliahModel>> getSavedWaktuKuliah();
}

class WaktuKuliahLocalDataSourceImplementation extends WaktuKuliahLocalDataSource{
    final SecureStorage secureStorage;
    static const String _waktuKuliah = 'waktu_kuliah_data';
  WaktuKuliahLocalDataSourceImplementation({required this.secureStorage});


  @override
  Future<List<WaktuKuliahModel>> getSavedWaktuKuliah() async{
    try {
      final jsonString = await secureStorage.getData(_waktuKuliah);
      if (jsonString.isEmpty) {
        return [];
      }
      final waktuKuliahJson = jsonDecode(jsonString) as List;
      return waktuKuliahJson.map((e) => WaktuKuliahModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> savedWaktuKuliah(List<WaktuKuliahModel> waktuKuliah) async {
    try {
      final waktuKuliahJson = waktuKuliah.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(waktuKuliahJson);
      secureStorage.saveData(_waktuKuliah, jsonString);
    } catch (e) {
      rethrow;
    }
  }
}