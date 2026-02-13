import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/login/data/models/token_model.dart';

abstract class LoginRemoteDataSource {
  Future<TokenModel> postLogin({
    required String username,
    required String password,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ConnectApi connectApi;

  LoginRemoteDataSourceImpl({required this.connectApi});

  @override
  Future<TokenModel> postLogin({
    required String username,
    required String password,
  }) async {
    try {
      final result = await connectApi.postLogin(
        username: username,
        password: password,
      );
      final token = TokenModel.fromJson(result);
      return token;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.api(e.toString());
    }
  }
}
