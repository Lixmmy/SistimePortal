// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profil.dart';

abstract class ProfilRepository {
  Future<Either<Failure,Profil>> getMahasiswa(int nim);
}