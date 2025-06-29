import 'dart:convert';

import 'package:newsistime/features/profil/data/models/profil_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfilRemoteDatasource {
  Future<ProfilModel> getMahasiswa(int nim);
}

class ProfilRemoteDataSourceImplementation extends ProfilRemoteDatasource {
  @override
  Future<ProfilModel> getMahasiswa(int nim) async {
    Uri uri = Uri.parse('https://portal.stmik-time.ac.id/api/mahasiswas/$nim');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ProfilModel.fromjson(data);
      } else {
        throw Exception(
          'Gagal mendapatkan data profil: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Gagal menghubungi API: $e');
    }
  }
}
