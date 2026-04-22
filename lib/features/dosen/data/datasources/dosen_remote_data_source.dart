import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/dosen/data/models/dosen_model.dart';

abstract class DosenRemoteDataSource {
  Future<List<DosenModel>> getDosen();
}

class DosenRemoteDataSourceImplementation extends DosenRemoteDataSource {
  final ConnectApi connectApi;

  DosenRemoteDataSourceImplementation({required this.connectApi});

  @override
  Future<List<DosenModel>> getDosen() async{
    try {
      final response = await connectApi.getDosen();
      return response;
    } on MessageExc{
      rethrow;
    }catch (e) {
      throw MessageExc.api(
        'An error in getDosen occurred: ${e.toString()}',
      );
    }
  }
}
