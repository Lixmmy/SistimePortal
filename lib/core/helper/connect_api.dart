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
import 'package:newsistime/features/dosen/data/models/dosen_model.dart';
import 'package:newsistime/features/khs/data/models/khs_model.dart';
import 'package:newsistime/features/krs/data/models/krs_model.dart';
import 'package:newsistime/features/krs/data/models/matkul_model.dart';
import 'package:newsistime/features/krs/data/models/skedul_model.dart';
import 'package:newsistime/features/krs/data/models/skema_model.dart';
import 'package:newsistime/features/krs/data/models/tahun_ajaran_model.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/login/data/models/token_model.dart';
import 'package:newsistime/features/profil/data/models/profil_model.dart';
import 'package:newsistime/features/profil/data/models/update_mahasiswa_model.dart';
import 'package:newsistime/features/program_studi/data/models/program_studi_models.dart';
import 'package:newsistime/features/status/data/models/status_model.dart';
import 'package:newsistime/features/status_mahasiswa/data/models/status_mahasiswa_model.dart';
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
        queryParameters: idSkemaKrs != null ? {'idSkemaKrs': idSkemaKrs} : null,
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
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
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
    dynamic body,
  ) async {
    try {
      await _ensureInternetConnection();
      Uri uri = Uri(scheme: scheme, host: host, path: endpoint);
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      String token = await secureStorage.getData('token');
      if (authorization == true) {
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
        if (token.isEmpty) {
          throw MessageExc.api(response.body);
        } else {
          throw MessageExc.tokenExpired();
        }
      } else if (response.statusCode == 404) {
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
      } else if (response.statusCode == 500) {
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
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
        throw MessageExc.api("Page Not Found: ${response.statusCode}");
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
    return (response as List)
        .map((e) => KrsModel.fromJson(e))
        .toList()
        .cast<KrsModel>();
  }

  Future<List<KhsModel>> getKhs({required String id}) async {
    final response = await _requestGet('$khsRoute/$id', true);
    return (response as List)
        .map((e) => KhsModel.fromJson(e))
        .toList()
        .cast<KhsModel>();
  }

  Future<List<TranskripModel>> getTranskrip({required String idUser}) async {
    final response = await _requestGet('$transkripRoute/$idUser', true);
    return (response as List)
        .map((e) => TranskripModel.fromJson(e))
        .toList()
        .cast<TranskripModel>();
  }

  Future<List<AgamaModel>> getAgama() async {
    final response = await _requestGet(agamaRoute, true);
    return (response as List)
        .map((item) => AgamaModel.fromJson(item))
        .toList()
        .cast<AgamaModel>();
  }

  Future<List<WaktuKuliahModel>> getWaktuKuliah() async {
    final response = await _requestGet(waktuKuliahRoute, true);
    return (response as List)
        .map((item) => WaktuKuliahModel.fromJson(item))
        .toList()
        .cast<WaktuKuliahModel>();
  }

  Future<List<StatusModel>> getStatus() async {
    final response = await _requestGet(statusRoute, true);
    return (response as List)
        .map((item) => StatusModel.fromJson(item))
        .toList()
        .cast<StatusModel>();
  }

  Future<List<ProgramStudiModel>> getProgramStudi() async {
    final response = await _requestGet(programStudiRoute, true);
    return (response as List)
        .map((item) => ProgramStudiModel.fromJson(item))
        .toList()
        .cast<ProgramStudiModel>();
  }

  Future<List<MatkulModel>> getMataKuliah() async {
    final response = await _requestGet(mataKuliahRoute, true);
    return (response as List)
        .map((e) => MatkulModel.fromJson(e))
        .toList()
        .cast<MatkulModel>();
  }

  Future<List<SkedulModel>> getSkedulKrs(String idSkemaKrs) async {
    final response = await _requestGet(
      getSkedulKrsRoute,
      true,
      idSkemaKrs: idSkemaKrs,
    );
    return (response as List)
        .map((e) => SkedulModel.fromJson(e))
        .toList()
        .cast<SkedulModel>();
  }

  Future<List<SkemaModel>> getSkemaKrs() async {
    final response = await _requestGet(getSkemaKrsRoute, true);
    return (response as List)
        .map((e) => SkemaModel.fromJson(e))
        .toList()
        .cast<SkemaModel>();
  }

  Future<List<TahunAjaranModel>> getTahunAjaran() async {
    final response = await _requestGet(getTahunAjaranRoute, true);
    return (response as List)
        .map((e) => TahunAjaranModel.fromJson(e))
        .toList()
        .cast<TahunAjaranModel>();
  }

  Future<StatusMahasiswaModel> getStatusMahasiswa(String idUser) async {
    final response = await _requestGet(
      '$getStatusMahasiswaRoute/$idUser',
      true,
    );
    return StatusMahasiswaModel.fromJson(response);
  }

  Future<List<DosenModel>> getDosen() async {
    final response = await _requestGet(getDosenRoute, true);
    return (response as List)
        .map((e) => DosenModel.fromJson(e))
        .toList()
        .cast<DosenModel>();
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

  Future<List<KrsModel>> postKrs({
    required String id,
    required List<Krs> krs,
  }) async {
    final body = krs
        .map(
          (e) => {
            'id': e.id,
            'idUser': e.idUser,
            'idSkedul': e.idSkedul,
            'tipeSkedul': e.tipeSkedul,
            'keterangan': e.keterangan,
          },
        )
        .toList();
    final response = await _requestPost('$krsRoute/$id', true, body);
    return (response as List)
        .map((e) => KrsModel.fromJson(e))
        .toList()
        .cast<KrsModel>();
  }

  Future<void> postChangePassword({required String newPassword}) async {
    return _requestPost(changePassword, true, {"password": newPassword});
  }
}
