import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/core/helper/connect_api.dart';
import 'package:newsistime/features/login/data/models/token_model.dart';

abstract class LoginRemoteDataSource {
  Future<TokenModel> postLogin({
    required String username,
    required String password,
  });
  Future<void> postChangePassword(String newPassword);
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

      return result;
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.api(e.toString());
    }
  }

  @override
  Future<void> postChangePassword(String newPassword) async {
    try {
      return await connectApi.postChangePassword(newPassword: newPassword);
    } on MessageExc {
      rethrow;
    } catch (e) {
      throw MessageExc.api('An error in Changepassword : ${e.toString()}');
    }
  }
}
