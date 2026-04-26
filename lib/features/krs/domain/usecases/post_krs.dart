import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/repositories/krs_repositories.dart';

class PostKrs {
  final KrsRepositories repository;

  PostKrs(this.repository);

  Future<Either<MessageExc, List<Krs>>> call({required List<Krs> krs}) async {
    return await repository.postKrs(krs: krs);
  }
}
