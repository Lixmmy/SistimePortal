import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/profil/data/models/update_mahasiswa_model.dart';
import 'package:sistime_portal/features/profil/domain/repositories/profil_repository.dart';

class PatchMahasiswa {
  final ProfilRepository profilRepo;

  const PatchMahasiswa({required this.profilRepo});

  Future<Either<MessageExc, void>> execute(
    String idUser,
    UpdateMahasiswaModel updateMahasiswaModel,
  ) async {
    return await profilRepo.patchMahasiswa(idUser, updateMahasiswaModel);
  }
}
