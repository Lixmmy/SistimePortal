import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/domain/repositories/profil_repository.dart';

class PatchMahasiswa {
  final ProfilRepository profilRepo;

  const PatchMahasiswa({required this.profilRepo});

  Future<Either<MessageExc, Profil>> execute(Profil profil) async {
    return await profilRepo.patchMahasiswa(profil);
  }
}
