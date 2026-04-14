import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/domain/entities/skedul_krs.dart';
import 'package:newsistime/features/krs/domain/repositories/krs_repositories.dart';

class GetSkedulKrs {
  final KrsRepositories krsRepositories;

  const GetSkedulKrs({required this.krsRepositories});

  Future<Either<MessageExc, List<SkedulKrs>>> execute(String idSkemaKrs) async {
    return await krsRepositories.getSkedulKrs(idSkemaKrs: idSkemaKrs);
  }
}
