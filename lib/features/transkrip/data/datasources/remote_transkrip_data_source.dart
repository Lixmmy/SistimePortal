import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/helper/connect_api.dart';
import 'package:sistime_portal/features/transkrip/data/models/transkrip_model.dart';

abstract class RemoteTranskripDataSource {
  Future<List<TranskripModel>> getTranskrip({required String idUser});
}

class RemoteTranskripDataSourceImplementation
    extends RemoteTranskripDataSource {
  final ConnectApi connectApi;
  RemoteTranskripDataSourceImplementation({required this.connectApi});

  @override
  Future<List<TranskripModel>> getTranskrip({required String idUser}) async {
    try {
      final response = await connectApi.getTranskrip(idUser: idUser);
      return response;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(
        'An unexpected error in getTranskrip occurred: ${e.toString()}',
      );
    }
  }
}
