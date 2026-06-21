import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/krs/domain/entities/matkul.dart';
import 'package:sistime_portal/features/krs/domain/repositories/krs_repositories.dart';

class GetMataKuliah {
  final KrsRepositories krsRepositories;

  GetMataKuliah({required this.krsRepositories});

  Future<Either<MessageExc, List<Matkul>>> execute() async {
    return await krsRepositories.getMataKuliah();
  }
}
