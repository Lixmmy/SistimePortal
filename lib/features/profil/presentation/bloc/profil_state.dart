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

  const ProfilLoaded(this.detailUser);

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
