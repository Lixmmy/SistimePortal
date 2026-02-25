part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class LoginBiometricSupportChecked extends LoginState {
  final bool isSupported;
  final bool canAuthenticate;
  final bool hasEnrolledBiometrics;
  final bool isHaveCredentials;

  const LoginBiometricSupportChecked({
    required this.isSupported,
    required this.canAuthenticate,
    required this.hasEnrolledBiometrics,
    required this.isHaveCredentials,
  });

  @override
  List<Object> get props => [
    isSupported,
    canAuthenticate,
    isHaveCredentials,
    hasEnrolledBiometrics,
  ];
}

class LoginBiometricAuthenticating extends LoginState {}

class LoginBiometricSuccess extends LoginState {}

class LoginBiometricFailure extends LoginState {
  final String message;

  const LoginBiometricFailure({required this.message});
  @override
  List<Object> get props => [message];
}
