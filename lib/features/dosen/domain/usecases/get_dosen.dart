import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/dosen/domain/entities/dosen.dart';
import 'package:sistime_portal/features/dosen/domain/repositories/dosen_repository.dart';

class GetDosen {
  final DosenRepository repository;

  GetDosen({required this.repository});

  Future<Either<MessageExc, List<Dosen>>> call() async {
    return await repository.getDosen();
  }
}
