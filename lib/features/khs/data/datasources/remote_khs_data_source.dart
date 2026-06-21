import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/helper/connect_api.dart';
import 'package:sistime_portal/features/khs/data/models/khs_model.dart';

abstract class RemoteKhsDataSource {
  Future<List<KhsModel>> getKhs({required String id});
}

class RemoteKhsDataSourceImplementation extends RemoteKhsDataSource {
  final ConnectApi connectApi;

  RemoteKhsDataSourceImplementation({required this.connectApi});

  @override
  Future<List<KhsModel>> getKhs({required String id}) async {
    try {
      final response = await connectApi.getKhs(id: id);
      return response;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown('An unexpected error occurred: ${e.toString()}');
    }
  }
}
