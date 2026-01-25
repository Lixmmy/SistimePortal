import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';

import '../models/profil_model.dart';

abstract class ProfilRemoteDatasource {
  Future<ProfilModel> getMahasiswa(String nim);
}

class ProfilRemoteDataSourceImplementation extends ProfilRemoteDatasource {
  final ConnectApi connectApi;

  ProfilRemoteDataSourceImplementation({required this.connectApi});

  @override
  Future<ProfilModel> getMahasiswa(String nim) async {
    try {
      final response = await connectApi.getMahasiswa(nim: nim);
      return ProfilModel.fromjson(response);
    } catch (e) {
      throw MessageExc.api(
        'An error in getMahasiswa occurred: ${e.toString()}',
      );
    }
  }
}
