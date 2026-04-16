import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/transkrip/data/models/transkrip_model.dart';

abstract class RemoteTranskripDataSource {
  Future<List<TranskripModel>> getTranskrip({required String nim});
}

class RemoteTranskripDataSourceImplementation
    extends RemoteTranskripDataSource {
  final ConnectApi connectApi;
  RemoteTranskripDataSourceImplementation({required this.connectApi});

  @override
  Future<List<TranskripModel>> getTranskrip({required String nim}) async {
    try {
      final response = await connectApi.getTranskrip(nim: nim);
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
