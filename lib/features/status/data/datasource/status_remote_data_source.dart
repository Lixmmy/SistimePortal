import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/helper/connect_api.dart';
import 'package:sistime_portal/features/status/data/models/status_model.dart';

abstract class StatusRemoteDataSource {
  Future<List<StatusModel>> getStatus();
}

class StatusRemoteDataSourceImpl implements StatusRemoteDataSource {
  final ConnectApi connectApi;

  StatusRemoteDataSourceImpl({required this.connectApi});

  @override
  Future<List<StatusModel>> getStatus() async {
    try {
      return await connectApi.getStatus();
    } catch (e) {
      throw MessageExc.api('An error in getStatus occurred: ${e.toString()}');
    }
  }
}
