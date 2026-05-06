import 'package:dartz/dartz.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/login/domain/repositories/login_repositories.dart';

class PostChangePassword {
  final LoginRepositories loginRepositories;

  const PostChangePassword({required this.loginRepositories});

  Future<Either<MessageExc, void>> execute({
    required String newPassword,
  }) async {
    return await loginRepositories.postChangePassword(newPassword: newPassword);
  }
}
