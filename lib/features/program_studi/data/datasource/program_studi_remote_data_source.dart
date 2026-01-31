import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/program_studi/data/models/program_studi_models.dart';

abstract class ProgramStudiRemoteDataSource {
  Future<List<ProgramStudiModel>> getProgramStudi();
}

class ProgramStudiRemoteDataSourceImplementation
    extends ProgramStudiRemoteDataSource {
  final ConnectApi connectApi;
  ProgramStudiRemoteDataSourceImplementation({required this.connectApi});
  @override
  Future<List<ProgramStudiModel>> getProgramStudi() async {
    try {
      final response = await connectApi.getProgramStudi();
      return response.map((e) => ProgramStudiModel.fromJson(e)).toList();
    } catch (e) {
      throw MessageExc.api(
        'An error in getProgramStudi occurred: ${e.toString()}',
      );
    }
  }
}
