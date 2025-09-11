import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/repositories/krs_repositories.dart';

class GetMataKuliah {
  final KrsRepositories krsRepositories;

  GetMataKuliah({required this.krsRepositories});

  Future<Either<MessageExc, List<Matkul>>> execute() async {
    return await krsRepositories.getMataKuliah();
  }
}
