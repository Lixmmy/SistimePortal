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

  Future<dynamic> _requestGet(String endpoint, bool authorization) async {
    try {
      await internetConnection();
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
        throw MessageExc.api("Internal Server Error: ${response.statusCode}");
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

  Future<dynamic> _requestPost(
    String endpoint,
    bool authorization,
    Map<String, dynamic> body,
  ) async {
    try {
      await internetConnection();
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
        throw MessageExc.tokenExpired();
      } else if (response.statusCode == 404) {
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
      } else if (response.statusCode == 500) {
        throw MessageExc.api("Internal Server Error: ${response.statusCode}");
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

  Future<dynamic> getMataKuliah() {
    return _requestGet(mataKuliahRoute, true);
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
}
