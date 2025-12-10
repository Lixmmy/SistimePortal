import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/khs/data/models/khs_model.dart';
import 'package:newsistime/features/khs/domain/entities/khs.dart';

abstract class RemoteKhsDataSource {
  Future<List<Khs>> getKhs({required String nim});
}

class RemoteKhsDataSourceImplementation extends RemoteKhsDataSource {
  final ConnectApi connectApi;

  RemoteKhsDataSourceImplementation({required this.connectApi});

  @override
  Future<List<Khs>> getKhs({required String nim}) async {
    try {
      final response = await connectApi.getKhs(nim: nim);
      if (response != null) {
        final khsModel = ListKhsModel.fromJson(response).listKhsModel;
        return khsModel.map((e) => e.toEntity()).toList();
      } else {
        throw MessageExc.api('No data found');
      }
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown('An unexpected error occurred: ${e.toString()}');
    }
  }
}
