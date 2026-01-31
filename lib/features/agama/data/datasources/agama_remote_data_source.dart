import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/agama/data/models/agama_model.dart';

abstract class AgamaRemoteDataSource {
  Future<List<AgamaModel>> getAgama();
}

class AgamaRemoteDataSourceImplementation extends AgamaRemoteDataSource {
  final ConnectApi connectApi;
  AgamaRemoteDataSourceImplementation({required this.connectApi});
  @override
  Future<List<AgamaModel>> getAgama() async {
    try {
      final response = await connectApi.getAgama();
      return response.map((e) => AgamaModel.fromJson(e)).toList();
    } catch (e) {
      throw MessageExc.api('An error in getAgama occurred: ${e.toString()}');
    }
  }
}
