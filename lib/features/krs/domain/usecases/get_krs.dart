import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/repositories/krs_repositories.dart';

class GetKrs {
  final KrsRepositories krsRepositories;

  GetKrs({required this.krsRepositories});

  Future<Either<MessageExc, List<Krs>>> execute(String id) async {
    return await krsRepositories.getKrs(id: id);
  }
}
