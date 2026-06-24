import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/krs/domain/entities/tahun_ajaran.dart';
import 'package:sistime_portal/features/krs/domain/repositories/krs_repositories.dart';

class GetTahunAjaran {
  final KrsRepositories krsRepositories;

  GetTahunAjaran({required this.krsRepositories});

  Future<Either<MessageExc, List<TahunAjaran>>> execute() async {
    return await krsRepositories.getTahunAjaran();
  }
}
