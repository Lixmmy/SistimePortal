part of 'khs_bloc.dart';

abstract class KhsState extends Equatable {
  const KhsState();

  @override
  List<Object> get props => [];
}

class KhsInitial extends KhsState {}

class KhsLoading extends KhsState {}

class KhsLoaded extends KhsState {
  final Map<int, List<Khs>> groupedKhs;
  final String username;
  final Profil profil;

  const KhsLoaded({required this.groupedKhs, required this.username,   required this.profil});

  @override
  List<Object> get props => [groupedKhs, username, profil];
}

class KhsError extends KhsState {
  final String message;

  const KhsError({required this.message});

  @override
  List<Object> get props => [message];
}

class KhsPdfDownloaded extends KhsState {
  final String filePath;

  const KhsPdfDownloaded({required this.filePath});

  @override
  List<Object> get props => [filePath];
}
