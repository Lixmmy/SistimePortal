import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/login/domain/entities/token.dart';

abstract class LoginRepositories {
  Future<Either<MessageExc, Token>> postLogin({
    required String username,
    required String password,
  });
}
