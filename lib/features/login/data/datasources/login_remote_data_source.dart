import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/features/login/data/models/token_model.dart';
import 'package:newsistime/features/login/domain/entities/token.dart';

abstract class LoginRemoteDataSource {
  Future<Token> postLogin({required String username, required String password});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ConnectApi connectApi;

  LoginRemoteDataSourceImpl({required this.connectApi});

  @override
  Future<Token> postLogin({
    required String username,
    required String password,
  }) async {
    try {
      final result = await connectApi.postLogin(
        username: username,
        password: password,
      );
      final token = TokenModel.fromJson(result);
      await SecureStorage().saveData('token', result['token']);
      return token.toEntity();
    } catch (e) {
      throw MessageExc.api(e.toString());
    }
  }
}
