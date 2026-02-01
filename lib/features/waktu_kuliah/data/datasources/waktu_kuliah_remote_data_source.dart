import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/waktu_kuliah/data/models/waktu_kuliah_model.dart';

abstract class WaktuKuliahRemoteDataSource {
  Future<List<WaktuKuliahModel>> getWaktuKuliahList();
}

class WaktuKuliahRemoteDataSourceImplementation
    extends WaktuKuliahRemoteDataSource {

      final ConnectApi connectApi;
  WaktuKuliahRemoteDataSourceImplementation({required this.connectApi});
  @override
  Future<List<WaktuKuliahModel>> getWaktuKuliahList() async{
    try {
      return await connectApi.getWaktuKuliah();
     
    } catch (e) {
      throw MessageExc.api(
          'An error in getWaktuKuliahList occurred: ${e.toString()}');
    }
  }
}
