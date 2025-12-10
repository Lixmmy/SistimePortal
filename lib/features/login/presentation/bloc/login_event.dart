part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventPostLogin extends LoginEvent {
  final String username;
  final String password;

  const LoginEventPostLogin({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
