import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/login/data/datasources/login_local_data_source.dart';
import 'package:newsistime/features/login/data/datasources/login_remote_data_source.dart';
import 'package:newsistime/features/login/domain/entities/token.dart';
import 'package:newsistime/features/login/domain/repositories/login_repositories.dart';

class LoginRepositoriesImplementation extends LoginRepositories {
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;
  LoginRepositoriesImplementation({
    required this.loginRemoteDataSource,
    required this.loginLocalDataSource,
  });

  @override
  Future<Either<MessageExc, Token>> postLogin({
    required String username,
    required String password,
  }) async {
    try {
      final result = await loginRemoteDataSource.postLogin(
        username: username,
        password: password,
      );
      await Future.wait({
        loginLocalDataSource.saveToken(result.token),
        loginLocalDataSource.savePassword(password),
        loginLocalDataSource.saveUsername(username),
      });
      return Right(result);
    } catch (e) {
      return Left(MessageExc.api(e.toString()));
    }
  }
}
