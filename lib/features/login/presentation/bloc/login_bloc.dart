import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/core/error/message_exc.dart';
import 'package:newsistime/features/login/data/datasources/login_local_data_source.dart';
import 'package:newsistime/features/login/domain/entities/token.dart';
import 'package:newsistime/features/login/domain/usecases/post_login_usecases.dart';
import 'package:newsistime/features/profil/domain/usecases/get_mahasiswa.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLoginUseCases postLoginUseCases;
  final GetMahasiswa getMahasiswa;
  final LoginLocalDataSource loginLocalDataSource;
  LoginBloc({
    required this.postLoginUseCases,
    required this.getMahasiswa,
    required this.loginLocalDataSource,
  }) : super(LoginInitial()) {
    on<LoginEventPostLogin>((event, emit) async {
      emit(LoginLoading());
      Either<MessageExc, Token> result = await postLoginUseCases.postLogin(
        username: event.username,
        password: event.password,
      );
      await result.fold((l) async => emit(LoginFailure(message: l.message)), (
        r,
      ) async {
        final profil = await getMahasiswa.execute(event.username);
        await profil.fold((l) async => emit(LoginFailure(message: l.message)), (
          r,
        ) async {
          emit(LoginSuccess());
        });
      });
    });
  }
}
