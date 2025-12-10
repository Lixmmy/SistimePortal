import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/login/domain/entities/token.dart';
import 'package:newsistime/features/login/domain/usecases/post_login_usecases.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLoginUseCases postLoginUseCases;
  LoginBloc({required this.postLoginUseCases}) : super(LoginInitial()) {
    on<LoginEventPostLogin>((event, emit) async {
      emit(LoginLoading());
      Either<MessageExc, Token> result = await postLoginUseCases.postLogin(
        username: event.username,
        password: event.password,
      );
      result.fold(
        (l) => emit(LoginFailure(message: l.message)),
        (r) => emit(LoginSuccess()),
      );
    });
  }
}
