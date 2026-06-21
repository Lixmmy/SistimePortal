import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/status/domain/entities/status.dart';
import 'package:sistime_portal/features/status/domain/repositories/status_repositories.dart';

class GetStatus {
  final StatusRepositories statusRepositories;
  GetStatus({required this.statusRepositories});
  Future<Either<MessageExc, List<Status>>> execute() async {
    return await statusRepositories.getStatus();
  }
}
