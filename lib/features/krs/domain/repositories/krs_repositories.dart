import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/krs/domain/entities/krs.dart';
import 'package:sistime_portal/features/krs/domain/entities/matkul.dart';
import 'package:sistime_portal/features/krs/domain/entities/skedul_krs.dart';
import 'package:sistime_portal/features/krs/domain/entities/skema_krs.dart';
import 'package:sistime_portal/features/krs/domain/entities/tahun_ajaran.dart';

abstract class KrsRepositories {
  Future<Either<MessageExc, List<Krs>>> getKrs({required String id});
  Future<Either<MessageExc, List<Matkul>>> getMataKuliah();
  Future<Either<MessageExc, List<SkemaKrs>>> getSkemaKrs();
  Future<Either<MessageExc, List<SkedulKrs>>> getSkedulKrs({
    required String idSkemaKrs,
  });
  Future<Either<MessageExc, List<TahunAjaran>>> getTahunAjaran();
  Future<Either<MessageExc, List<Krs>>> postKrs({
    required String id,
    required List<Krs> krs,
  });
}
