// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/profil/domain/entities/profil.dart';
import 'package:newsistime/features/profil/domain/repositories/profil_repository.dart';

class GetMahasiswa {
  final ProfilRepository profilRepo;

  const GetMahasiswa(this.profilRepo);
  
 Future<Either<MessageExc, Profil>> execute(String nim)async{
    return await profilRepo.getMahasiswa(nim);
  }
}
