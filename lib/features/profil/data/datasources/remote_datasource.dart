import 'dart:convert';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';

import '../models/profil_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfilRemoteDatasource {
  Future<Profil> getMahasiswa(String nim);
}

class ProfilRemoteDataSourceImplementation extends ProfilRemoteDatasource {
  @override
  Future<Profil> getMahasiswa(String nim) async {
    Uri uri = Uri.parse('https://portal.stmik-time.ac.id/api/mahasiswas/$nim');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ProfilModel.fromjson(data).toEntity();
      } else {
        throw MessageExc.api('Tidak dapat terhubung dengan server');
      }
    } catch (e) {
      throw MessageExc.api(e.toString());
    }
  }
}
