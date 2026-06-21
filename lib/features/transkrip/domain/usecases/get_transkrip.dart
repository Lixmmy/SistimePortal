import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/transkrip/domain/entities/transkrip.dart';
import 'package:sistime_portal/features/transkrip/domain/repositories/transkrip_repositories.dart';

class GetTranskrip {
  final TranskripRepositories transkripRepositories;

  GetTranskrip({required this.transkripRepositories});

  Future<Either<MessageExc, List<Transkrip>>> execute(String idUser) async {
    return await transkripRepositories.getTranskrip(idUser: idUser);
  }
}
