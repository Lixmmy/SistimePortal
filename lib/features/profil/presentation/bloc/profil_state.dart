part of 'profil_bloc.dart';

sealed class ProfilState extends Equatable {
  const ProfilState();

  @override
  List<Object?> get props => [];
}

final class ProfilInitial extends ProfilState {}

final class ProfilLoading extends ProfilState {}

final class ProfilLoaded extends ProfilState {
  final Profil detailUser;
  final String username;

  const ProfilLoaded(this.detailUser, this.username);

  @override
  List<Object?> get props => [detailUser];

  get profil => detailUser;
}

final class ProfilError extends ProfilState {
  final String message;

  const ProfilError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ProfilSuccessUpdate extends ProfilState {
  final String message;

  const ProfilSuccessUpdate({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ProfilLogout extends ProfilState {}

final class ProfilTokenExpired extends ProfilState {
  final String message;
  const ProfilTokenExpired({required this.message});

  @override
  List<Object?> get props => [message];
}
