import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/krs/data/models/krs_model.dart';
import 'package:newsistime/features/krs/data/models/matkul_model.dart';
import 'package:newsistime/features/krs/data/models/skedul_model.dart';
import 'package:newsistime/features/krs/data/models/skema_model.dart';
import 'package:newsistime/features/krs/domain/entities/skedul_krs.dart';
import 'package:newsistime/features/krs/domain/entities/skema_krs.dart';

abstract class RemoteKrsDataSource {
  Future<List<KrsModel>> getKrs({required String id});
  Future<List<MatkulModel>> getMataKuliah();
  Future<List<SkemaModel>> getSkemaKrs();
  Future<List<SkedulModel>> getSkedulKrs(String idSkemaKrs);
}

class RemoteKrsDataSourceImplementation extends RemoteKrsDataSource {
  final ConnectApi connectApi;
  RemoteKrsDataSourceImplementation({required this.connectApi});

  @override
  Future<List<KrsModel>> getKrs({required String id}) async {
    try {
      final response = await connectApi.getKrs(id: id);
      return response;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(
        'An unexpected error in getKrs occurred: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<MatkulModel>> getMataKuliah() async {
    try {
      final response = await connectApi.getMataKuliah();
      return response;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(
        'An unexpected error in  occurred: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<SkemaModel>> getSkemaKrs() async {
    try {
      final response = await connectApi.getSkemaKrs();
      return response;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(
        'An unexpected error in getSkemaKrs occurred: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<SkedulModel>> getSkedulKrs(String idSkemaKrs) async {
    try {
      final response = await connectApi.getSkedulKrs(idSkemaKrs);
      return response;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.unknown(
        'An unexpected error in getSkedulKrs occurred: ${e.toString()}',
      );
    }
  }
}
