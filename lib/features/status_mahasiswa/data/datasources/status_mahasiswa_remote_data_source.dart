import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/status_mahasiswa/data/models/status_mahasiswa_model.dart';

abstract class StatusMahasiswaRemoteDatasource {
  Future<StatusMahasiswaModel> getStatusMahasiswa(String idUser);
}

class StatusMahasiswaRemoteDataSourceImplementation
    extends StatusMahasiswaRemoteDatasource {
  final ConnectApi connectApi;
  StatusMahasiswaRemoteDataSourceImplementation({required this.connectApi});
  @override
  Future<StatusMahasiswaModel> getStatusMahasiswa(String idUser) async {
    try {
      final response = await connectApi.getStatusMahasiswa(idUser);
      return response;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw Exception(
        'An error in getStatusMahasiswa occurred: ${e.toString()}',
      );
    }
  }
}
