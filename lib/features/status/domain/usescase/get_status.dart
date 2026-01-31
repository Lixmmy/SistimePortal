import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/status/domain/entities/status.dart';
import 'package:newsistime/features/status/domain/repositories/status_repositories.dart';

class GetStatus {
  final StatusRepositories statusRepositories;
  GetStatus({required this.statusRepositories});
  Future<Either<MessageExc, List<Status>>> execute() async {
    return await statusRepositories.getStatus();
  }
}
