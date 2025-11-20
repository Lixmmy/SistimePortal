import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/transkrip/data/models/transkrip_model.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';

abstract class RemoteTranskripDataSource {
  Future<List<Transkrip>> getTranskrip({required String nim});
}

class RemoteTranskripDataSourceImplementation
    extends RemoteTranskripDataSource {
  final ConnectApi connectApi;
  RemoteTranskripDataSourceImplementation({required this.connectApi});

  @override
  Future<List<Transkrip>> getTranskrip({required String nim}) async {
    try {
      final response = await connectApi.getTranskrip(nim: nim);
      if (response != null) {
        final List<TranskripModel> transkripModel = ListTranskripModel.fromJson(
          response,
        ).listTranskripModel;
        return transkripModel.map((e) => e.toEntity()).toList();
      } else {
        throw MessageExc.api('Failed to fetch transkrip data.');
      }
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown('An unexpected error in getTranskrip occurred: ${e.toString()}');
    }
  }
}
