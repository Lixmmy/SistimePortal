import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/profil/domain/entities/profil.dart';
import 'package:sistime_portal/features/profil/domain/repositories/profil_repository.dart';

class GetMahasiswa {
  final ProfilRepository profilRepo;

  const GetMahasiswa({required this.profilRepo});

  Future<Either<MessageExc, Profil>> execute(String nim) async {
    return await profilRepo.getMahasiswa(nim);
  }
}
