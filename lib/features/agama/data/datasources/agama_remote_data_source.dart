import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/helper/connect_api.dart';
import 'package:sistime_portal/features/agama/data/models/agama_model.dart';

abstract class AgamaRemoteDataSource {
  Future<List<AgamaModel>> getAgama();
}

class AgamaRemoteDataSourceImplementation extends AgamaRemoteDataSource {
  final ConnectApi connectApi;
  AgamaRemoteDataSourceImplementation({required this.connectApi});
  @override
  Future<List<AgamaModel>> getAgama() async {
    try {
      return await connectApi.getAgama();
    } catch (e) {
      throw MessageExc.api('An error in getAgama occurred: ${e.toString()}');
    }
  }
}
