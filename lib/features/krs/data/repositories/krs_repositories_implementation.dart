import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/krs/data/datasources/remote_krs_data_source.dart';
import 'package:newsistime/features/krs/data/models/krs_model.dart';
import 'package:newsistime/features/krs/data/models/matkul_model.dart';
import 'package:newsistime/features/krs/data/models/skedul_model.dart';
import 'package:newsistime/features/krs/data/models/skema_model.dart';
import 'package:newsistime/features/krs/data/models/tahun_ajaran_model.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/entities/matkul.dart';
import 'package:newsistime/features/krs/domain/entities/skedul_krs.dart';
import 'package:newsistime/features/krs/domain/entities/skema_krs.dart';
import 'package:newsistime/features/krs/domain/entities/tahun_ajaran.dart';
import 'package:newsistime/features/krs/domain/repositories/krs_repositories.dart';

class KrsRepositoriesImplementation extends KrsRepositories {
  final RemoteKrsDataSource remoteKrsDataSource;

  KrsRepositoriesImplementation({required this.remoteKrsDataSource});

  @override
  Future<Either<MessageExc, List<Krs>>> getKrs({required String id}) async {
    try {
      final List<KrsModel> krsModel = await remoteKrsDataSource.getKrs(id: id);
      return Right(krsModel.map((e) => e.toEntity()).toList());
    } on MessageExc catch (e) {
      if (e.type == MessageExcType.tokenExpired) {
        return Left(e);
      } else {
        return Left(e);
      }
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }

  @override
  Future<Either<MessageExc, List<Matkul>>> getMataKuliah() async {
    try {
      final List<MatkulModel> matkul = await remoteKrsDataSource
          .getMataKuliah();
      return Right(matkul.map((e) => e.toEntity()).toList());
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }

  @override
  Future<Either<MessageExc, List<SkemaKrs>>> getSkemaKrs() async {
    try {
      final List<SkemaModel> skemaKrs = await remoteKrsDataSource.getSkemaKrs();
      return Right(skemaKrs.map((e) => e.toEntity()).toList());
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }

  @override
  Future<Either<MessageExc, List<SkedulKrs>>> getSkedulKrs({
    required String idSkemaKrs,
  }) async {
    try {
      final List<SkedulModel> skedulKrs = await remoteKrsDataSource
          .getSkedulKrs(idSkemaKrs);
      return Right(skedulKrs.map((e) => e.toEntity()).toList());
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }

  @override
  Future<Either<MessageExc, List<TahunAjaran>>> getTahunAjaran() async {
    try {
      final List<TahunAjaranModel> tahunAjaran = await remoteKrsDataSource
          .getTahunAjaran();
      return Right(tahunAjaran.map((e) => e.toEntity()).toList());
    } on MessageExc catch (e) {
      return Left(e);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }
}
