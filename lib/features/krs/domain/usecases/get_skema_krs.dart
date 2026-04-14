import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/domain/entities/skema_krs.dart';
import 'package:newsistime/features/krs/domain/repositories/krs_repositories.dart';

class GetSkemaKrs {
  final KrsRepositories krsRepositories;

  const GetSkemaKrs({required this.krsRepositories});

  Future<Either<MessageExc, List<SkemaKrs>>> execute() async {
    return await krsRepositories.getSkemaKrs();
  }
}
