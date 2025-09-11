import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/krs/data/models/krs_model.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';

abstract class RemoteKrsDataSource {
  Future<List<Krs>> getKrs({required String nim});
  Future<List<Matkul>> getMataKuliah();
}

class RemoteKrsDataSourceImplementation extends RemoteKrsDataSource {
  final ConnectApi connectApi;
  RemoteKrsDataSourceImplementation({required this.connectApi});

  @override
  Future<List<Krs>> getKrs({required String nim}) async {
    try {
      final response = await connectApi.getKrs(nim: nim);
      if (response != null) {
        final List<KrsModel> krsModel = ListKrsModel.fromJson(response).listKrsModel;
        return krsModel.map((e) => e.toEntity()).toList();
      } else {
        throw MessageExc.api('No data found');
      }
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<List<Matkul>> getMataKuliah() async {
    try {
      final response = await connectApi.getMataKuliah();
      if (response != null) {
        final List<MatkulModel> matkulModel = 
         ListMatkulModel.fromJson(response)
            .listMatkulModel;
        return matkulModel.map((e) => e.toEntity()).toList();
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
