// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/profil/data/models/update_mahasiswa_model.dart';

import '../entities/profil.dart';

abstract class ProfilRepository {
  Future<Either<MessageExc, Profil>> getMahasiswa(String nim);
  Future<Either<MessageExc, void>> patchMahasiswa(
    String idUser,
    UpdateMahasiswaModel updateMahasiswaModel,
  );
}
