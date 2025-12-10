import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/domain/repositories/profil_repository.dart';

class GetMahasiswa {
  final ProfilRepository profilRepo;
  final SecureStorage secureStorage;

  const GetMahasiswa({required this.profilRepo, required this.secureStorage});

  Future<Either<MessageExc, Profil>> execute() async {
    try {
      final username = await secureStorage.getData('username');
      if (username.isEmpty) {
        return Left(MessageExc.unknown('Username not found in storage.'));
      }
      return await profilRepo.getMahasiswa(username);
    } catch (e) {
      return Left(MessageExc.unknown(e.toString()));
    }
  }
}
