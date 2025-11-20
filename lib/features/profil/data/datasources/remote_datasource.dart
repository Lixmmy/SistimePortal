import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';

import '../models/profil_model.dart';

abstract class ProfilRemoteDatasource {
  Future<Profil> getMahasiswa(String nim);
}

class ProfilRemoteDataSourceImplementation extends ProfilRemoteDatasource {
  final ConnectApi connectApi;

  ProfilRemoteDataSourceImplementation({required this.connectApi});

  @override
  Future<Profil> getMahasiswa(String nim) async {
    try {
      final response = await connectApi.getMahasiswa(nim: nim);
      return ProfilModel.fromjson(response).toEntity();
    } catch (e) {
      throw MessageExc.api('An error in getMahasiswa occurred: ${e.toString()}');
    }
  }
}
