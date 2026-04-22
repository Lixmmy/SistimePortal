import 'package:dartz/dartz.dart';
import 'package:newsistime/features/dosen/domain/entities/dosen.dart';
import 'package:newsistime/features/dosen/domain/repositories/dosen_repository.dart';

class GetDosen {
  final DosenRepository repository;

  GetDosen({required this.repository});

  Future<Either<String, List<Dosen>>> call() async {
    return await repository.getDosen();
  }
}
