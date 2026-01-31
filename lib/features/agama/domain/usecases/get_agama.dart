import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/agama/domain/entities/agama.dart';
import 'package:newsistime/features/agama/domain/repositories/agama_repositories.dart';

class GetAgama {
  AgamaRepositories agamaRepositories;
  GetAgama({required this.agamaRepositories});
  
  Future<Either<MessageExc, List<Agama>>> execute() {
    return agamaRepositories.getAgama();
  }
}