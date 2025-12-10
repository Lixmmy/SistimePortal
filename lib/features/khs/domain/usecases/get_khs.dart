import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/khs/domain/entities/khs.dart';
import 'package:newsistime/features/khs/domain/repositories/khs_repositories.dart';

class GetKhs {
  final KhsRepositories repository;

  GetKhs(this.repository);

  Future<Either<MessageExc, List<Khs>>> call({required String nim}) {
    return repository.getKhs(nim: nim);
  }
}
