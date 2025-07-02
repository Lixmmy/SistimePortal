import 'dart:convert';

import '../../../../core/error/message_exception.dart';
import '../models/profil_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfilRemoteDatasource {
  Future<ProfilModel> getMahasiswa(String nim);
}

class ProfilRemoteDataSourceImplementation extends ProfilRemoteDatasource {
  @override
  Future<ProfilModel> getMahasiswa(String nim) async {
    Uri uri = Uri.parse('https://portal.stmik-time.ac.id/api/mahasiswas/$nim');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ProfilModel.fromjson(data);
      } else {
        throw FailureConncectApi(error: 'Tidak dapat terhubung dengan server');
      }
    } catch (e) {
      throw Exception('Gagal menghubungi API: $e');
    }
  }
}
