import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/helper/secure_storage.dart';
import 'package:sistime_portal/features/login/domain/usecases/post_change_password.dart';
import 'package:sistime_portal/features/profil/domain/usecases/patch_mahasiswa.dart';
import 'package:sistime_portal/features/login/domain/usecases/log_out_usecases.dart';
import 'package:sistime_portal/features/profil/data/models/update_mahasiswa_model.dart';
import '../../domain/entities/profil.dart';
import '../../domain/usecases/get_mahasiswa.dart';
import 'package:dartz/dartz.dart';
part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  final GetMahasiswa getMahasiswa;
  final LogOutUseCases logOutUseCases;
  final PatchMahasiswa patchMahasiswa;
  final PostChangePassword postChangePassword;
  ProfilBloc({
    required this.getMahasiswa,
    required this.patchMahasiswa,
    required this.logOutUseCases,
    required this.postChangePassword,
  }) : super(ProfilInitial()) {
    on<ProfilGetMahasiswa>((event, emit) async {
      emit(ProfilLoading());
      final username = await SecureStorage().getData('username');
      if (username.isEmpty) {
        emit(ProfilError(message: 'Username not found in storage.'));
        return;
      }
      Either<MessageExc, Profil> hasilGetMahasiswa = await getMahasiswa.execute(
        username,
      );
      hasilGetMahasiswa.fold(
        (leftHasilGetMahasiswa) async {
          if (leftHasilGetMahasiswa.type == MessageExcType.tokenExpired) {
            emit(ProfilTokenExpired(message: leftHasilGetMahasiswa.message));
          } else {
            emit(ProfilError(message: leftHasilGetMahasiswa.toString()));
          }
        },
        (rightHasilGetMahasiswa) {
          emit(ProfilLoaded(rightHasilGetMahasiswa, username));
        },
      );
    });
    on<ProfilUpdateMahasiswa>((event, emit) async {
      emit(ProfilLoading());
      final result = await patchMahasiswa.execute(
        event.idUser,
        event.updateProfil,
      );

      result.fold(
        (failure) async {
          if (failure.type == MessageExcType.tokenExpired) {
            emit(ProfilTokenExpired(message: failure.message));
          } else {
            emit(ProfilError(message: failure.message));
          }
        },
        (_) {
          emit(ProfilSuccessUpdate(message: 'Profile updated successfully.'));
          add(ProfilGetMahasiswa());
        },
      );
    });
    on<LogOutProfil>((event, emit) async {
      emit(ProfilLoading());
      final result = await logOutUseCases.logOut();
      result.fold(
        (failure) {
          emit(ProfilError(message: failure.message));
        },
        (_) {
          emit(ProfilLogout());
        },
      );
    });

    on<ProfilChangePassword>((event, emit) async {
      emit(ProfilLoading());
      final result = await postChangePassword.execute(
        newPassword: event.newPassword,
      );
      result.fold(
        (failure) {
          emit(ProfilError(message: failure.message));
        },
        (_) {
          emit(ProfilSuccessUpdate(message: 'Berhasil Merubah Password'));
          add(ProfilGetMahasiswa());
        },
      );
    });
  }
}
