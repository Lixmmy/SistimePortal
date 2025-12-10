import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/login/domain/entities/token.dart';
import 'package:newsistime/features/login/domain/repositories/login_repositories.dart';

class PostLoginUseCases {
  final LoginRepositories loginRepositories;

  PostLoginUseCases({required this.loginRepositories});

  Future<Either<MessageExc, Token>> postLogin({
    required String username,
    required String password,
  }) {
    return loginRepositories.postLogin(username: username, password: password);
  }
}
