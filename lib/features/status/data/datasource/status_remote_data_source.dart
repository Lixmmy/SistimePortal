import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/status/data/models/status_model.dart';

abstract class StatusRemoteDataSource {
  Future<List<StatusModel>> getStatus();
}

class StatusRemoteDataSourceImpl implements StatusRemoteDataSource {
  final ConnectApi connectApi;

  StatusRemoteDataSourceImpl({required this.connectApi});

  @override
  Future<List<StatusModel>> getStatus() async {
    try {
      final response = await connectApi.getStatus();
      return response.data.map((e) => StatusModel.fromJson(e)).toList();
    } catch (e) {
      throw MessageExc.api('An error in getStatus occurred: ${e.toString()}');
    }
  }
}
