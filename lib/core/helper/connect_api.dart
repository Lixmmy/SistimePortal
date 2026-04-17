import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/core/route_config/config.dart';
import 'package:newsistime/core/route_config/route_endpoint.dart';
import 'package:newsistime/features/agama/data/models/agama_model.dart';
import 'package:newsistime/features/khs/data/models/khs_model.dart';
import 'package:newsistime/features/krs/data/models/krs_model.dart';
import 'package:newsistime/features/krs/data/models/matkul_model.dart';
import 'package:newsistime/features/krs/data/models/skedul_model.dart';
import 'package:newsistime/features/krs/data/models/skema_model.dart';
import 'package:newsistime/features/krs/data/models/tahun_ajaran_model.dart';
import 'package:newsistime/features/login/data/models/token_model.dart';
import 'package:newsistime/features/profil/data/models/profil_model.dart';
import 'package:newsistime/features/profil/data/models/update_mahasiswa_model.dart';
import 'package:newsistime/features/program_studi/data/models/program_studi_models.dart';
import 'package:newsistime/features/status/data/models/status_model.dart';
import 'package:newsistime/features/transkrip/data/models/transkrip_model.dart';
import 'package:newsistime/features/waktu_kuliah/data/models/waktu_kuliah_model.dart';

class ConnectApi {
  final SecureStorage secureStorage;
  final InternetConnection internetConnection;
  const ConnectApi({
    required this.secureStorage,
    required this.internetConnection,
  });

  Future<bool> _ensureInternetConnection() async {
    if (kIsWeb) {
      return true;
    }
    var connectivityResult = await (Connectivity().checkConnectivity());

    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      bool hasInternet = await InternetConnection().hasInternetAccess;
      if (!hasInternet) {
        throw MessageExc.network();
      }
      return true;
    }
  }

  Future<dynamic> _requestGet(
    String endpoint,
    bool authorization, {
    String? idSkemaKrs,
  }) async {
    try {
      await _ensureInternetConnection();
      Uri uri = Uri(
        scheme: scheme,
        host: host,
        path: endpoint,
        queryParameters: {'idSkemaKrs': idSkemaKrs},
      );
      final Map<String, String> headers = {'Accept': 'application/json'};
      if (authorization == true) {
        String token = await secureStorage.getData('token');
        if (token.isEmpty) {
          throw MessageExc.tokenExpired();
        }
        headers['Authorization'] = 'Bearer $token';
      }
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw MessageExc.tokenExpired();
      } else if (response.statusCode == 404) {
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
      } else if (response.statusCode == 500) {
        throw MessageExc.api(response.body);
      } else {
        throw MessageExc.unknown(response.body);
      }
    } on TimeoutException {
      throw MessageExc.timeout();
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(e.toString());
    }
  }

  Future<dynamic> _requestPost(
    String endpoint,
    bool authorization,
    Map<String, dynamic> body,
  ) async {
    try {
      await _ensureInternetConnection();
      Uri uri = Uri(scheme: scheme, host: host, path: endpoint);
      print(uri);
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if (authorization == true) {
        String token = await secureStorage.getData('token');
        if (token.isEmpty) {
          throw MessageExc.tokenExpired();
        }
        headers['Authorization'] = 'Bearer $token';
      }
      final response = await http
          .post(uri, headers: headers, body: json.encode(body))
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw MessageExc.tokenExpired();
      } else if (response.statusCode == 404) {
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
      } else if (response.statusCode == 500) {
        throw MessageExc.api(response.body);
      } else {
        throw MessageExc.unknown(response.body);
      }
    } on TimeoutException {
      throw MessageExc.timeout();
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(e.toString());
    }
  }

  Future<dynamic> _requestPatch(
    String endpoint,
    bool authorization,
    Map<String, dynamic> body,
  ) async {
    try {
      await _ensureInternetConnection();
      Uri uri = Uri(scheme: scheme, host: host, path: endpoint);
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if (authorization == true) {
        String token = await secureStorage.getData('token');
        if (token.isEmpty) {
          throw MessageExc.tokenExpired();
        }
        headers['Authorization'] = 'Bearer $token';
      }
      final response = await http
          .patch(uri, headers: headers, body: json.encode(body))
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body);
        }
        return null;
      } else if (response.statusCode == 401) {
        throw MessageExc.tokenExpired();
      } else if (response.statusCode == 404) {
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
      } else if (response.statusCode == 500) {
        throw MessageExc.api(response.body);
      } else {
        throw MessageExc.unknown(response.body);
      }
    } on TimeoutException {
      throw MessageExc.timeout();
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(e.toString());
    }
  }

  Future<ProfilModel> getMahasiswa({required String nim}) async {
    final response = await _requestGet('$mahasiswaRoute/$nim', true);
    return ProfilModel.fromjson(response);
  }

  Future<List<KrsModel>> getKrs({required String id}) async {
    final response = await _requestGet('$krsRoute/$id', true);
    return response.map((e) => KrsModel.fromJson(e)).toList();
  }

  Future<List<KhsModel>> getKhs({required String id}) async {
    final response = await _requestGet('$khsRoute/$id', true);
    return response.map((e) => KhsModel.fromJson(e)).toList();
  }

  Future<List<TranskripModel>> getTranskrip({required String nim}) async {
    final response = await _requestGet('$transkripRoute/$nim', true);
    return response.map((e) => TranskripModel.fromJson(e)).toList();
  }

  Future<List<AgamaModel>> getAgama() async {
    final response = await _requestGet(agamaRoute, true);
    return (response as List).map((item) => AgamaModel.fromJson(item)).toList();
  }

  Future<List<WaktuKuliahModel>> getWaktuKuliah() async {
    final response = await _requestGet(waktuKuliahRoute, true);
    return (response as List)
        .map((item) => WaktuKuliahModel.fromJson(item))
        .toList();
  }

  Future<List<StatusModel>> getStatus() async {
    final response = await _requestGet(statusRoute, true);
    return (response as List)
        .map((item) => StatusModel.fromJson(item))
        .toList();
  }

  Future<List<ProgramStudiModel>> getProgramStudi() async {
    final response = await _requestGet(programStudiRoute, true);
    return (response as List)
        .map((item) => ProgramStudiModel.fromJson(item))
        .toList();
  }

  Future<List<MatkulModel>> getMataKuliah() async {
    final response = await _requestGet(mataKuliahRoute, true);
    return response.map((e) => MatkulModel.fromJson(e)).toList();
  }

  Future<List<SkedulModel>> getSkedulKrs(String idSkemaKrs) async {
    final response = await _requestGet(
      getSkedulKrsRoute,
      true,
      idSkemaKrs: idSkemaKrs,
    );
    return response.map((e) => SkedulModel.fromJson(e)).toList();
  }

  Future<List<SkemaModel>> getSkemaKrs() async {
    final response = await _requestGet(getSkemaKrsRoute, true);
    return response.map((e) => SkemaModel.fromJson(e)).toList();
  }

  Future<List<TahunAjaranModel>> getTahunAjaran() async {
    final response = await _requestGet(getTahunAjaranRoute, true);
    return response.map((e) => TahunAjaranModel.fromJson(e)).toList();
  }

  Future<TokenModel> postLogin({
    required String username,
    required String password,
  }) async {
    final response = await _requestPost(loginRoute, false, {
      'username': username,
      'password': password,
    });
    return TokenModel.fromJson(response);
  }

  Future<void> patchMahasiswa({
    required String idUser,
    required UpdateMahasiswaModel updateMahasiswaModel,
  }) {
    return _requestPatch(
      '$patchMahasiswaRoute/$idUser',
      true,
      updateMahasiswaModel.toJson(),
    );
  }
}
