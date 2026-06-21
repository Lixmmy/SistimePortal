import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/krs/domain/entities/krs.dart';
import 'package:sistime_portal/features/krs/domain/repositories/krs_repositories.dart';

class PostKrs {
  final KrsRepositories repository;

  PostKrs(this.repository);

  Future<Either<MessageExc, List<Krs>>> call({
    required String id,
    required List<Krs> krs,
  }) async {
    return await repository.postKrs(id: id, krs: krs);
  }
}
