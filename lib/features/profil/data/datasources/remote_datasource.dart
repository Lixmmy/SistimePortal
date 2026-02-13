import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/profil/data/models/update_mahasiswa_model.dart';

import '../models/profil_model.dart';

abstract class ProfilRemoteDatasource {
  Future<ProfilModel> getMahasiswa(String nim);
  Future<void> patchMahasiswa(
    String idUser,
    UpdateMahasiswaModel updateMahasiswaModel,
  );
}

class ProfilRemoteDataSourceImplementation extends ProfilRemoteDatasource {
  final ConnectApi connectApi;

  ProfilRemoteDataSourceImplementation({required this.connectApi});

  @override
  Future<ProfilModel> getMahasiswa(String nim) async {
    try {
      final response = await connectApi.getMahasiswa(nim: nim);
      return ProfilModel.fromjson(response);
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.api(
        'An error in getMahasiswa occurred: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> patchMahasiswa(
    String idUser,
    UpdateMahasiswaModel updateMahasiswaModel,
  ) async {
    try {
      return await connectApi.patchMahasiswa(
        idUser: idUser,
        updateMahasiswaModel: updateMahasiswaModel,
      );
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.api(
        'An error in patchMahasiswa occurred: ${e.toString()}',
      );
    }
  }
}
