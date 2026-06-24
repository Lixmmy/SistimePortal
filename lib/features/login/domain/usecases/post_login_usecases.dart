import 'package:dartz/dartz.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/localization/localization_service.dart';
import 'package:sistime_portal/features/login/domain/entities/token.dart';
import 'package:sistime_portal/features/login/domain/repositories/login_repositories.dart';

class PostLoginUseCases {
  final LoginRepositories loginRepositories;

  PostLoginUseCases({required this.loginRepositories});

  Future<Either<MessageExc, Token>> postLogin({
    required String username,
    required String password,
  }) {
    if (username.isEmpty) {
      throw MessageExc.unknown(appL10n.usernameCannotBeEmpty);
    }
    if (password.isEmpty) {
      throw MessageExc.unknown(appL10n.passwordCannotBeEmpty);
    }
    // if (password.length < 8) {
    //   throw MessageExc.unknown(appL10n.passwordIsTooShort);
    // }

    return loginRepositories.postLogin(username: username, password: password);
  }
}
