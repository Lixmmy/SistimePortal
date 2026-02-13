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
import 'package:newsistime/features/profil/data/models/update_mahasiswa_model.dart';
import 'package:newsistime/features/program_studi/data/models/program_studi_models.dart';
import 'package:newsistime/features/status/data/models/status_model.dart';
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
        throw MessageExc.network(
          'Tidak ada WIFI atau internet yang tersambung',
        );
      }
      return true;
    }
  }

  Future<dynamic> _requestGet(String endpoint, bool authorization) async {
    try {
      await _ensureInternetConnection();
      Uri uri = Uri(scheme: scheme, host: host, path: endpoint);
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
      throw MessageExc.unknown('Koneksi timeout, silakan coba lagi.');
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
        String message = response.body;
        if (message == 'Unauthorized') {
          throw MessageExc.tokenExpired();
        } else {
          throw MessageExc.api(message);
        }
      } else if (response.statusCode == 404) {
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
      } else if (response.statusCode == 500) {
        throw MessageExc.api(response.body);
      } else {
        throw MessageExc.unknown(response.body);
      }
    } on TimeoutException {
      throw MessageExc.network('Koneksi timeout, silakan coba lagi.');
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
        String message = response.body;
        if (message == 'Unauthorized') {
          throw MessageExc.tokenExpired();
        } else {
          throw MessageExc.api(message);
        }
      } else if (response.statusCode == 404) {
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
      } else if (response.statusCode == 500) {
        throw MessageExc.api(response.body);
      } else {
        throw MessageExc.network(response.body);
      }
    } on TimeoutException {
      throw MessageExc.network('Koneksi timeout, silakan coba lagi.');
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(e.toString());
    }
  }

  Future<dynamic> getMahasiswa({required String nim}) {
    return _requestGet('$mahasiswaRoute/$nim', true);
  }

  Future<dynamic> getKrs({required String id}) {
    return _requestGet('$krsRoute/$id', true);
  }

  Future<dynamic> getKhs({required String id}) {
    return _requestGet('$khsRoute/$id', true);
  }

  Future<dynamic> getTranskrip({required String nim}) {
    return _requestGet('$transkripRoute/$nim', true);
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

  Future<dynamic> postLogin({
    required String username,
    required String password,
  }) {
    return _requestPost(loginRoute, false, {
      'username': username,
      'password': password,
    });
  }

  Future<dynamic> patchMahasiswa({
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
