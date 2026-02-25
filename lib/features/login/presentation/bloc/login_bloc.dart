import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/login/data/datasources/login_local_data_source.dart';
import 'package:newsistime/features/login/domain/entities/token.dart';
import 'package:newsistime/features/login/domain/usecases/post_login_usecases.dart';
import 'package:local_auth/local_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLoginUseCases postLoginUseCases;
  final LoginLocalDataSource loginLocalDataSource;
  final LocalAuthentication localAuthentication;

  LoginBloc({
    required this.postLoginUseCases,
    required this.loginLocalDataSource,
    required this.localAuthentication,
  }) : super(LoginInitial()) {
    on<LoginEventPostLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        Either<MessageExc, Token> result = await postLoginUseCases.postLogin(
          username: event.username,
          password: event.password,
        );
        result.fold((l) => emit(LoginFailure(message: l.message)), (r) async {
          emit(LoginSuccess());
        });
      } on MessageExc catch (e) {
        emit(LoginFailure(message: e.message));
      } catch (e) {
        emit(LoginFailure(message: e.toString()));
      }
    });

    on<CheckBiometricSupport>((event, emit) async {
      final bool canCheckBiometrics =
          await localAuthentication.canCheckBiometrics;
      final bool isDeviceSupported = await localAuthentication
          .isDeviceSupported();
      final String username = await loginLocalDataSource.getUsername();
      final String password = await loginLocalDataSource.getPassword();
      final bool isHaveCredentials = username.isNotEmpty && password.isNotEmpty;
      final List<BiometricType> availableBiometrics = await localAuthentication
          .getAvailableBiometrics();
      final bool hasEnrolledBiometrics = availableBiometrics.isNotEmpty;
      emit(
        LoginBiometricSupportChecked(
          isSupported: isDeviceSupported,
          canAuthenticate: canCheckBiometrics && isDeviceSupported,
          hasEnrolledBiometrics: hasEnrolledBiometrics,
          isHaveCredentials: isHaveCredentials,
        ),
      );
    });

    on<AuthenticateWithBiometrics>((event, emit) async {
      emit(LoginBiometricAuthenticating());
      try {
        final bool didAuthenticate = await localAuthentication.authenticate(
          localizedReason: 'Please authenticate to log in',
          biometricOnly: true,
        );

        if (didAuthenticate) {
          final result = await Future.wait([
            loginLocalDataSource.getUsername(),
            loginLocalDataSource.getPassword(),
          ]);
          final String username = result[0];
          final String password = result[1];
          if (username.isNotEmpty && password.isNotEmpty) {
            Either<MessageExc, Token> result = await postLoginUseCases
                .postLogin(username: username, password: password);
            result.fold(
              (l) => emit(
                LoginBiometricFailure(
                  message: 'Biometric login failed: ${l.message}',
                ),
              ),
              (r) => emit(LoginSuccess()),
            );
          } else {
            emit(
              const LoginBiometricFailure(
                message: 'Biometric login failed: No stored credentials.',
              ),
            );
          }
        } else {
          emit(
            const LoginBiometricFailure(
              message: 'Biometric authentication cancelled or failed.',
            ),
          );
        }
      } catch (e) {
        emit(
          LoginBiometricFailure(
            message: 'Biometric authentication error: ${e.toString()}',
          ),
        );
      }
    });
  }
}
