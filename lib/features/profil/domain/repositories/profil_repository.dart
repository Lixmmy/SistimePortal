// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';

import '../entities/profil.dart';

abstract class ProfilRepository {
  Future<Either<MessageExc,Profil>> getMahasiswa(String nim);
}
