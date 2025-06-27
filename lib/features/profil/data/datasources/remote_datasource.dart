import 'dart:convert';

import 'package:newsistime/features/profil/data/models/profil_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDatasource {
  Future<ProfilModel> getMahasiswa(int nim);
}

class ProfilRemoteDataSourceImplementation extends RemoteDatasource {
  @override
  Future<ProfilModel> getMahasiswa(int nim) async {
    Uri uri = Uri.parse('https://portal.stmik-time.ac.id/api/mahasiswas/$nim');

    final response = await http.get(uri);

    final data = json.decode(response.body);
    return ProfilModel.fromjson(data);
  }
}
