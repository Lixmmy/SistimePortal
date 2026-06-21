import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/features/login/domain/entities/token.dart';

abstract class LoginRepositories {
  Future<Either<MessageExc, Token>> postLogin({
    required String username,
    required String password,
  });
  Future<Either<MessageExc, void>> logOut();
  Future<Either<MessageExc, void>> postChangePassword({
    required String newPassword,
  });
}
