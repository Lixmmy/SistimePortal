import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/login/data/datasources/login_remote_data_source.dart';
import 'package:newsistime/features/login/domain/entities/token.dart';
import 'package:newsistime/features/login/domain/repositories/login_repositories.dart';

class LoginRepositoriesImplementation extends LoginRepositories {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoriesImplementation({required this.loginRemoteDataSource});

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
      return Right(result);
    } catch (e) {
      return Left(MessageExc.api(e.toString()));
    }
  }
}
