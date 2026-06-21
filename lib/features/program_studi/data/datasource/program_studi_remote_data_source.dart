import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/helper/connect_api.dart';
import 'package:sistime_portal/features/program_studi/data/models/program_studi_models.dart';

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
      return await connectApi.getProgramStudi();
    } catch (e) {
      throw MessageExc.api(
        'An error in getProgramStudi occurred: ${e.toString()}',
      );
    }
  }
}
