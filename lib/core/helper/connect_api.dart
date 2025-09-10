import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/core/route_config/config.dart';
import 'package:newsistime/core/route_config/route_endpoint.dart';

class ConnectApi {
  final SecureStorage secureStorage;
  const ConnectApi({required this.secureStorage});

  Future<void> internetConnection() async {
    bool hasInternet = await InternetConnection().hasInternetAccess;
    if (!hasInternet) {
      throw MessageExc.network('Tidak ada koneksi internet');
    }
  }

  Future<Map<String, String>> header({bool authorization = true}) async {
    Map<String, String> headers = {
      // 'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (authorization == true) {
      String token = await secureStorage.getData('token');
      if (token.isEmpty) {
        throw MessageExc.tokenExpired();
      }
      headers['Authorization'] = 'Bearer $token';
      return headers;
    } else {
      return headers;
    }
  }

  Future<dynamic> _requestGet(String endpoint, bool authorization) async {
    await internetConnection();
    try {
      Uri uri = Uri(scheme: scheme, host: host, path: endpoint);
      final headers = await header(authorization: authorization);
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw MessageExc.network(
          'Gagal memuat data. Kode Status: ${response.statusCode}',
        );
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
    return _requestGet('$mahasiswaRoute/$nim', false);
  }

  Future<dynamic> getKrs({required String nim}) {
    return _requestGet('$krsRoute/$nim', false);
  }

  Future<dynamic> getTranskrip({required String nim}) {
    return _requestGet('$transkripRoute/$nim', false);
  }

  Future<dynamic> getMataKuliah() {
    return _requestGet(mataKuliahRoute, false);
  }
}
