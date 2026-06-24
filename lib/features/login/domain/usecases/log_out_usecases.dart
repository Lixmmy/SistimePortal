import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/login/domain/repositories/login_repositories.dart';

class LogOutUseCases {
  final LoginRepositories loginRepositories;

  LogOutUseCases({required this.loginRepositories});

  Future<Either<MessageExc, void>> logOut() {
    return loginRepositories.logOut();
  }
}
