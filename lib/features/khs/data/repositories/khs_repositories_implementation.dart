import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/khs/data/datasources/remote_khs_data_source.dart';
import 'package:sistime_portal/features/khs/data/models/khs_model.dart';
import 'package:sistime_portal/features/khs/domain/entities/khs.dart';
import 'package:sistime_portal/features/khs/domain/repositories/khs_repositories.dart';

class KhsRepositoriesImplementation extends KhsRepositories {
  final RemoteKhsDataSource remoteKhsDataSource;

  KhsRepositoriesImplementation({required this.remoteKhsDataSource});

  @override
  Future<Either<MessageExc, List<Khs>>> getKhs({required String id}) async {
    try {
      final List<KhsModel> khs = await remoteKhsDataSource.getKhs(id: id);
      return Right(khs.map((e) => e.toEntity()).toList());
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }
}
