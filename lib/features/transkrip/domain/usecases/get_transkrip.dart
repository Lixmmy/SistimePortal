import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/features/transkrip/domain/repositories/transkrip_repositories.dart';

class GetTranskrip {
  final TranskripRepositories transkripRepositories;

  GetTranskrip({required this.transkripRepositories});

  Future<Either<MessageExc, List<Transkrip>>> execute(String nim) async {
    return await transkripRepositories.getTranskrip(nim: nim);
  }

}